//
//  YMArrayModel.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMArrayModel.h"

#import "NSMutableArray+YMExtension.h"

static NSString * const kYMMutableArray = @"mutableArray";

@interface YMArrayModel ()
@property (nonatomic, strong) NSMutableArray *mutableArray;

@end

@implementation YMArrayModel

@dynamic array;

#pragma mark - Initializations and Deallocations

- (instancetype)init {
	self = [super init];

	if (self) {
		self.mutableArray = [NSMutableArray array];
	}

	return self;
}

#pragma mark - Accessors

- (NSArray *)array {
	return [self.mutableArray copy];
}

- (NSUInteger)count {
	return self.mutableArray.count;
}

#pragma mark - Methods

- (void)addModel:(id)model {
	[self.mutableArray addObject:model];

	self.state = YMModelDidChange;
}

- (void)removeModel:(id)model {
	[self.mutableArray removeObject:model];

	self.state = YMModelDidChange;
}

- (void)addModels:(NSArray *)models {
	for (id model in models) {
		[self addModel:model];
	}
}

- (void)insertModel:(id)model atIndex:(NSUInteger)index {
	[self.mutableArray insertObject:model atIndex:index];

	self.state = YMModelDidChange;
}
- (void)removeModelAtIndex:(NSUInteger)index {
	[self.mutableArray removeObjectAtIndex:index];

	self.state = YMModelDidChange;
}

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
	[self.mutableArray moveObjectFromIndex:fromIndex toIndex:toIndex];

	self.state = YMModelDidChange;
}

- (void)updateModel:(id)model {
	self.state = YMModelDidChange;
}

- (NSUInteger)indexOfModel:(id)model {
	return [self.mutableArray indexOfObject:model];
}

- (id)modelAtIndex:(NSUInteger)index {
	return [self.mutableArray objectAtIndex:index];
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx {
	return [self modelAtIndex:idx];
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:self.mutableArray forKey:kYMMutableArray];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];

	if (self) {
		self.mutableArray = [aDecoder decodeObjectForKey:kYMMutableArray];
	}

	return self;
}

#pragma mark - NSFastEnumeration

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
								  objects:(id  _Nullable __unsafe_unretained [])buffer
									count:(NSUInteger)len
{
	return [self.mutableArray countByEnumeratingWithState:state objects:buffer count:len];
}

@end
