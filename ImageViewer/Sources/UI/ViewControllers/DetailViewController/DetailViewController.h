//
//  DetailViewController.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/10/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class YMArrayModel;

@interface DetailViewController : NSViewController
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) YMArrayModel *arrayModel;

- (IBAction)onNextButton:(id)sender;
- (IBAction)onBackButton:(id)sender;
- (IBAction)onCloseButton:(id)sender;
- (IBAction)onBlurButton:(id)sender;

@end
