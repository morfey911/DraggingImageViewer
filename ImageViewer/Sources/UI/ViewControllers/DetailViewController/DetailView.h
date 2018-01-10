//
//  DetailView.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/10/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class YMImageModel;

@interface DetailView : NSView
@property (nonatomic, strong) IBOutlet NSButton		*backButton;
@property (nonatomic, strong) IBOutlet NSButton		*nextButton;
@property (nonatomic, strong) IBOutlet NSImageView 	*imageView;

- (void)applyBlurToImage;

- (void)fillWithModel:(YMImageModel *)model;

@end
