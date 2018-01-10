//
//  YMImageView.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/11/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMImageView.h"

#import "YMImageModel.h"
#import "YMModelProtocol.h"

@implementation YMImageView

#pragma mark - Initializations and Deallocations

- (void)dealloc {
	self.imageModel = nil;
}

#pragma mark - Accessors

- (void)setImageModel:(YMImageModel *)imageModel {
	if (_imageModel != imageModel) {
		[_imageModel removeObserver:self];
		_imageModel = imageModel;
		[_imageModel addObserver:self];

		[_imageModel load];
	}
}

#pragma mark - Public methods

- (void)fillWithModel:(YMImageModel *)model {
	self.imageView.image = model.image;
}

#pragma mark - YMModel

- (void)modelWillLoad:(YMImageModel *)model {
	[self.progressIndicator startAnimation:self];
}

- (void)modelDidLoad:(YMImageModel *)model {
	[self fillWithModel:model];
	[self.progressIndicator stopAnimation:self];
}

@end
