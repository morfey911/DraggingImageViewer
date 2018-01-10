//
//  DetailViewController.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/10/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "DetailViewController.h"
#import "DetailView.h"

#import "YMArrayModel.h"
#import "YMImageModel.h"

@interface DetailViewController ()
@property (nonatomic, readonly) YMImageModel 	*currentModel;
@property (nonatomic, readonly) DetailView		*detailView;

@end

@implementation DetailViewController

#pragma mark - Accessors

- (YMImageModel *)currentModel {
	return self.arrayModel[self.currentIndex];
}

- (DetailView *)detailView {
	if (self.isViewLoaded && [self.view isKindOfClass:[DetailView class]]) {
		return (DetailView *)self.view;
	}

	return nil;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.detailView fillWithModel:self.currentModel];
}

#pragma mark - Actions handling

- (IBAction)onNextButton:(id)sender {
	NSInteger newCurrentIndex = self.currentIndex + 1;

	if (newCurrentIndex <= self.arrayModel.count - 1) {
		self.currentIndex = newCurrentIndex;
		[self.detailView fillWithModel:self.currentModel];
	}
}

- (IBAction)onBackButton:(id)sender {
	NSInteger newCurrentIndex = self.currentIndex - 1;

	if (newCurrentIndex >= 0) {
		self.currentIndex = newCurrentIndex;
		[self.detailView fillWithModel:self.currentModel];
	}
}

- (IBAction)onCloseButton:(id)sender {
	[self.view removeFromSuperview];
	[self removeFromParentViewController];
}

- (IBAction)onBlurButton:(id)sender {
	[self.detailView applyBlurToImage];
}

@end
