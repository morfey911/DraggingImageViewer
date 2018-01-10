//
//  YMModelProtocol.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YMModel;

@protocol YMModelProtocol <NSObject>

@optional

- (void)modelWillLoad:(YMModel *)model;

- (void)modelDidFailLoading:(YMModel *)model;

- (void)modelDidLoad:(YMModel *)model;

- (void)model:(YMModel *)model didChangeWithObject:(id)object;

@end
