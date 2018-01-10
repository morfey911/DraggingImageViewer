//
//  YMImageModel.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "YMImageModel.h"
#import "YMMacros.h"
#import "NSImage+YMExtension.h"

@interface YMImageModel ()
@property (nonatomic, copy) NSString 	*fileName;
@property (nonatomic, strong) NSURL 	*url;
@property (nonatomic, strong) NSImage 	*image;

@end

@implementation YMImageModel

#pragma mark - Class metrhods

+ (instancetype)imageModelWithURL:(NSURL *)url {
	return [[self alloc] initWithURL:url];
}

+ (instancetype)imageModelWithURLString:(NSString *)urlString {
	return [[self alloc] initWithURLString:urlString];
}

#pragma mark - Initializations and Deallocations

- (instancetype)initWithURLString:(NSString *)urlString {
	return [self initWithURL:[NSURL fileURLWithPath: urlString]];
}

- (instancetype)initWithURL:(NSURL *)url {
	self = [super init];

	if (self) {
		self.url = url;
		self.fileName = url.lastPathComponent;
	}

	return self;
}

#pragma mark - YMModel methods

- (void)load {
	self.state = YMModelWillLoad;

	YMWeakify(self);
	dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
		YMStrongify(self);
		NSImage *image = [[[NSImage alloc] initWithContentsOfURL:self.url] preloadedImage];

		dispatch_async(dispatch_get_main_queue(), ^{
			self.image = image;
			self.state = YMModelDidLoad;
		});
	});
}

@end
