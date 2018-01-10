//
//  YMImageModel.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMModel.h"

@interface YMImageModel : YMModel
@property (nonatomic, readonly) NSImage 	*image;
@property (nonatomic, readonly) NSString 	*fileName;

+ (instancetype)imageModelWithURL:(NSURL *)url;
+ (instancetype)imageModelWithURLString:(NSString *)urlString;

- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithURLString:(NSString *)urlString;

@end
