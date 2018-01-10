//
//  OverviewViewItem.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/7/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef void(^VoidBlock)(void);

@class YMImageView;
@class YMImageModel;

@interface OverviewViewItem : NSCollectionViewItem
@property (nonatomic, strong) IBOutlet YMImageView *previewImageView;
@property (nonatomic, copy) VoidBlock onDoubleClickBlock;

- (void)fillWithModel:(YMImageModel *)model;

@end
