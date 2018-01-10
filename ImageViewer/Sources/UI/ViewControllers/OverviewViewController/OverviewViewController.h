//
//  OverviewViewController.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/7/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class YMArrayModel;

@interface OverviewViewController : NSViewController <NSCollectionViewDataSource>
@property (nonatomic, readonly) YMArrayModel *arrayModel;

@end
