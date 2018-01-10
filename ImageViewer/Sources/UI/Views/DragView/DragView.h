//
//  DragView.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/9/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DragViewProtocol.h"

@interface DragView : NSView <NSDraggingDestination>

@property (nonatomic, weak) IBOutlet id<DragViewProtocol> delegate;

@end
