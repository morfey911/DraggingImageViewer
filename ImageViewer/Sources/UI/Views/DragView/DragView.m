//
//  DragView.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/9/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "DragView.h"

static const int kYMDragLineWidth = 10;

@interface DragView ()
@property (nonatomic, readonly) NSDictionary *filteringOptions;
@property (nonatomic, assign, getter=isReceivingDrag) BOOL receivingDrag;

- (void)setup;
- (BOOL)shouldAllowForDraggingInfo:(id <NSDraggingInfo>)info;

@end

@implementation DragView

#pragma mark - Accessors

- (void)setReceivingDrag:(BOOL)receivingDrag {
	if (_receivingDrag != receivingDrag) {
		_receivingDrag = receivingDrag;

		self.needsDisplay = YES;
	}
}

- (NSDictionary *)filteringOptions {
	return @{NSPasteboardURLReadingContentsConformToTypesKey : [NSImage imageTypes]};
}

#pragma mark - Initializations and Deallocations

- (instancetype)initWithCoder:(NSCoder *)decoder {
	self = [super initWithCoder:decoder];

	if (self) {
		[self setup];
	}

	return self;
}

- (instancetype)initWithFrame:(NSRect)frameRect {
	self = [super initWithFrame:frameRect];

	if (self) {
		[self setup];
	}

	return self;
}

#pragma mark - View lifecycle

- (void)drawRect:(NSRect)dirtyRect {
	if (self.isReceivingDrag) {
		NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.bounds];

		[NSColor.selectedControlColor set];

		path.lineWidth = kYMDragLineWidth;

		[path stroke];
	}
}

#pragma mark - Private methods

- (void)setup {
	[self registerForDraggedTypes:@[NSURLPboardType]];
}

- (BOOL)shouldAllowForDraggingInfo:(id <NSDraggingInfo>)info {
	if ([info.draggingPasteboard canReadObjectForClasses:@[[NSURL class]] options:self.filteringOptions]) {
		return true;
	}

	return false;
}

#pragma mark - NSDraggingDestination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender {
	self.receivingDrag = YES;

	return [self shouldAllowForDraggingInfo:sender] ? NSDragOperationCopy : NSDragOperationNone;
}

- (BOOL)prepareForDragOperation:(id<NSDraggingInfo>)sender {
	return [self shouldAllowForDraggingInfo:sender];
}

- (BOOL)performDragOperation:(id<NSDraggingInfo>)sender {
	NSArray<NSURL *> *urls = [sender.draggingPasteboard readObjectsForClasses:@[[NSURL class]]
																	  options:self.filteringOptions];

	self.receivingDrag = NO;

	if (urls && urls.count > 0){
		[self.delegate dragView:self didReceiveImageURLs:urls];
		return YES;
	}

	return NO;
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
	self.receivingDrag = NO;
}

@end
