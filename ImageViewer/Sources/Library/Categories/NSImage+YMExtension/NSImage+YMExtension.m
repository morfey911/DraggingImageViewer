//
//  NSImage+YMExtension.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/11/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "NSImage+YMExtension.h"

@implementation NSImage (YMExtension)

- (NSImage *)preloadedImage {
	CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)self.TIFFRepresentation, NULL);
	CGImageRef image = CGImageSourceCreateImageAtIndex(source, 0, NULL);;

	// make a bitmap context of a suitable size to draw to, forcing decode
	size_t width = CGImageGetWidth(image);
	size_t height = CGImageGetHeight(image);

	CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef imageContext =  CGBitmapContextCreate(NULL, width, height, 8, width*4, colourSpace,
													   kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrder32Little);
	CGColorSpaceRelease(colourSpace);

	// draw the image to the context, release it
	CGContextDrawImage(imageContext, CGRectMake(0, 0, width, height), image);

	// now get an image ref from the context
	CGImageRef outputImage = CGBitmapContextCreateImage(imageContext);

	NSImage *cachedImage = [[NSImage alloc] initWithCGImage:outputImage size:NSZeroSize];

	// clean up
	CGImageRelease(outputImage);
	CGContextRelease(imageContext);

	return cachedImage;
}

@end
