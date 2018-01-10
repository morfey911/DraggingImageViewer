//
//  DetailView.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/10/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <CoreImage/CoreImage.h>

#import "DetailView.h"

#import "YMImageModel.h"

@interface DetailView ()
@property (nonatomic, strong) CIFilter *blurFilter;

@end

@implementation DetailView

#pragma mark - Accessors

- (CIFilter *)blurFilter {
	if (!_blurFilter) {
		_blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
		[_blurFilter setDefaults];
		[_blurFilter setValue:@10 forKey:@"inputRadius"];
	}

	return _blurFilter;
}

#pragma mark - View lifecycle

- (void)drawRect:(NSRect)dirtyRect {
	self.layer.backgroundColor = NSColor.whiteColor.CGColor;
}

#pragma mark - Public methods

- (void)applyBlurToImage {
	NSImageView *imageView = self.imageView;

	if (imageView.contentFilters.count == 0) {
		imageView.contentFilters = @[self.blurFilter];
	} else {
		imageView.contentFilters = @[];
	}
}

- (void)fillWithModel:(YMImageModel *)model {
	self.imageView.image = model.image;
}

@end
