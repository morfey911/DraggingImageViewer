//
//  DragViewProtocol.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/9/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DragView;

@protocol DragViewProtocol

@optional

- (void)dragView:(DragView *)dragView didReceiveImageURLs:(NSArray *)URLs;

@end
