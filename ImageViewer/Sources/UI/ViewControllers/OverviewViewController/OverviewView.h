//
//  OverviewView.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/7/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class DragView;

@interface OverviewView : NSView
@property (nonatomic, strong) IBOutlet DragView			*dragView;
@property (nonatomic, strong) IBOutlet NSTextField 		*emptyStateTextField;
@property (nonatomic, strong) IBOutlet NSCollectionView *collectionView;

@end
