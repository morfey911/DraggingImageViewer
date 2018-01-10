//
//  YMModel.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMObservableObject.h"

typedef NS_ENUM(NSUInteger, YMModelState) {
	YMModelNotLoaded,
	YMModelWillLoad,
	YMModelDidFailLoading,
	YMModelDidLoad,
	YMModelDidChange
};

@interface YMModel : YMObservableObject

- (void)load;

- (void)setupLoading;

- (void)performLoading;

@end
