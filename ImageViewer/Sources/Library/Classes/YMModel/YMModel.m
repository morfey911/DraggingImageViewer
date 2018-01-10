//
//  YMModel.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMModel.h"
#import "YMModelProtocol.h"
#import "YMMacros.h"

@implementation YMModel

#pragma mark - Public

- (void)load {
	@synchronized(self) {
		NSUInteger state = self.state;

		if (YMModelDidLoad == state || YMModelWillLoad == state) {
			[self notifyObservers];

			return;
		}

		self.state = YMModelWillLoad;
	}

	[self setupLoading];

	YMWeakify(self);
	dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
		YMStrongify(self);
		[self performLoading];
	});
}

- (void)setupLoading {

}

- (void)performLoading {
	[self doesNotRecognizeSelector:_cmd];
}

#pragma mark - Observable Object

- (SEL)selectorForState:(NSUInteger)state {
	SEL selector = nil;

	switch (state) {
		case YMModelWillLoad:
			selector = @selector(modelWillLoad:);
			break;

		case YMModelDidFailLoading:
			selector = @selector(modelDidFailLoading:);
			break;

		case YMModelDidLoad:
			selector = @selector(modelDidLoad:);
			break;

		case YMModelDidChange:
			selector = @selector(model:didChangeWithObject:);
			break;

		default:
			selector = [super selectorForState:state];
			break;
	}

	return selector;
}

@end
