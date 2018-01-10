//
//  YMObservableObject.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMObservableObject.h"

@interface YMObservableObject ()
@property (nonatomic, assign) BOOL			shouldNotify;
@property (nonatomic, retain) id			target;
@property (nonatomic, retain) NSHashTable 	*observersHashTable;

- (void)performBlock:(void(^)(void))block shouldNotify:(BOOL)shouldNotify;

@end

@implementation YMObservableObject

@synthesize state = _state;

@dynamic observersSet;

#pragma mark - Class methods

+ (instancetype)observableObjectWithTarget:(id)target {
	return [[self alloc] initWithTarget: target];
}

#pragma mark - Initializations and Deallocations

- (void)dealloc {
	self.observersHashTable = nil;
}

- (instancetype)init {
	return [self initWithTarget:nil];
}

- (instancetype)initWithTarget:(id)target {
	self = [super init];

	if (self) {
		self.shouldNotify = YES;
		self.observersHashTable = [NSHashTable weakObjectsHashTable];
		self.target = target ? target : self;
	}

	return self;
}

#pragma mark - Accessors

- (void)setState:(NSUInteger)state {
	[self setState:state withObject:nil];
}

- (void)setState:(NSUInteger)state withObject:(id)object {
	@synchronized(self) {
		if (_state != state) {
			_state = state;
		}

		if (self.shouldNotify) {
			[self notifyObserversWithObject:object];
		}
	}
}

- (NSUInteger)state {
	@synchronized(self) {
		return _state;
	}
}

- (NSSet *)observersSet {
	@synchronized(self) {
		return self.observersHashTable.setRepresentation;
	}
}

#pragma mark - Public methods

- (void)addObserver:(id)observer {
	@synchronized(self) {
		[self.observersHashTable addObject:observer];
	}
}

- (void)removeObserver:(id)observer {
	@synchronized(self) {
		[self.observersHashTable removeObject:observer];
	}
}

- (void)removeObservers {
	@synchronized(self) {
		[self.observersHashTable removeAllObjects];
	}
}

- (BOOL)containsObserver:(id)observer {
	@synchronized(self) {
		return [self.observersHashTable containsObject:observer];
	}
}

- (SEL)selectorForState:(NSUInteger)state {
	return nil;
}

- (void)notifyObservers {
	[self notifyObserversWithObject:nil];
}

- (void)notifyObserversWithObject:(id)object {
	[self notifyObserversWithSelector:[self.target selectorForState:self.state] withObject:object];
}

- (void)notifyObserversWithSelector:(SEL)selector withObject:(id)object {
	for (id observer in self.observersHashTable) {
		if ([observer respondsToSelector:selector]) {
			[observer performSelector:selector withObject:self.target withObject:object];
		}
	}
}

- (void)performBlockWithNotification:(void (^)(void))block {
	[self performBlock:block shouldNotify:YES];
}

- (void)performBlockWithoutNotification:(void (^)(void))block {
	[self performBlock:block shouldNotify:NO];
}

#pragma mark - Private methods

- (void)performBlock:(void (^)(void))block shouldNotify:(BOOL)shouldNotify {
	@synchronized (self) {
		BOOL notificationState = self.shouldNotify;
		self.shouldNotify = shouldNotify;

		if (block) {
			block();
		}

		self.shouldNotify = notificationState;
	}
}

@end
