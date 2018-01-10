//
//  OverviewViewItem.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/7/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "OverviewViewItem.h"

#import "YMImageModel.h"
#import "YMImageView.h"

@implementation OverviewViewItem

#pragma mark - Methods

- (void)fillWithModel:(YMImageModel *)model {
	self.previewImageView.imageModel = model; // Better to use preview image here
	self.textField.stringValue = model.fileName;
}

- (void)mouseDown:(NSEvent *)event {
	[super mouseDown:event];

	VoidBlock onDoubleClickBlock = self.onDoubleClickBlock;

	if (event.clickCount > 1) {
		if (onDoubleClickBlock) {
			onDoubleClickBlock();
		}
	}
}

@end
