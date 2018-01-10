//
//  OverviewViewController.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/7/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "OverviewViewController.h"
#import "OverviewViewItem.h"
#import "OverviewView.h"

#import "YMArrayModel.h"
#import "YMImageModel.h"
#import "YMModelProtocol.h"
#import "DragViewProtocol.h"
#import "DetailViewController.h"

#import "YMMacros.h"

@interface OverviewViewController ()
@property (nonatomic, strong)	YMArrayModel 	*arrayModel;
@property (nonatomic, readonly) OverviewView 	*overviewView;

@end

@implementation OverviewViewController

#pragma mark - Initializations and Deallocations

- (void)dealloc {
	self.arrayModel = nil;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
	self = [super initWithCoder:coder];

	if (self) {
		self.arrayModel = [YMArrayModel new];
	}

	return self;
}

- (instancetype)initWithNibName:(NSNibName)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

	if (self) {
		self.arrayModel = [YMArrayModel new];
	}

	return self;
}

#pragma mark - Accessors

- (OverviewView *)overviewView {
	if (self.isViewLoaded && [self.view isKindOfClass:[OverviewView class]]) {
		return (OverviewView *)self.view;
	}

	return nil;
}

- (void)setArrayModel:(YMArrayModel *)arrayModel {
	if (_arrayModel != arrayModel) {
		[_arrayModel removeObserver:self];
		_arrayModel = arrayModel;
		[_arrayModel addObserver:self];
	}
}

#pragma mark - NSCollectionViewDataSource

- (nonnull NSCollectionViewItem *)collectionView:(nonnull NSCollectionView *)collectionView
			 itemForRepresentedObjectAtIndexPath:(nonnull NSIndexPath *)indexPath {
	YMArrayModel *arrayModel = self.arrayModel;
	OverviewViewItem *cell = [collectionView makeItemWithIdentifier:NSStringFromClass([OverviewViewItem class])
													   forIndexPath:indexPath];

	[cell fillWithModel:[arrayModel modelAtIndex:indexPath.item]];
	
	YMWeakify(self);
	cell.onDoubleClickBlock = ^{
		YMStrongify(self);
		NSView *view = self.overviewView;
		DetailViewController *controller = [[DetailViewController alloc]
											initWithNibName:NSStringFromClass([DetailViewController class]) bundle:nil];

		controller.currentIndex = indexPath.item;
		controller.arrayModel = arrayModel;

		[self addChildViewController:controller];
		[view addSubview:controller.view];

		controller.view.frame = view.bounds;
	};

	return cell;
}

- (NSInteger)collectionView:(nonnull NSCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return self.arrayModel.count;
}

#pragma mark - DragViewProtocol

- (void)dragView:(DragView *)dragView didReceiveImageURLs:(NSArray *)URLs {
	NSMutableArray *result = [NSMutableArray arrayWithCapacity:URLs.count];

	[URLs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[result addObject:[YMImageModel imageModelWithURL:obj]];
	}];

	[self.arrayModel addModels:result];
}

#pragma mark - YMModel

- (void)model:(YMModel *)model didChangeWithObject:(id)object {
	[self.overviewView.collectionView reloadData];
	[self.overviewView.emptyStateTextField setHidden: 0 < self.arrayModel.count];
}

@end
