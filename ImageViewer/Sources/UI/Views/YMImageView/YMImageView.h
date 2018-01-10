//
//  YMImageView.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/11/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class YMImageModel;

@interface YMImageView : NSView
@property (nonatomic, strong) IBOutlet NSImageView 			*imageView;
@property (nonatomic, strong) IBOutlet NSProgressIndicator 	*progressIndicator;

@property (nonatomic, strong) YMImageModel 					*imageModel;

- (void)fillWithModel:(YMImageModel *)model;

@end
