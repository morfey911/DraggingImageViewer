//
//  YMArrayModel.h
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "YMModel.h"

@interface YMArrayModel : YMModel <NSCoding, NSFastEnumeration>
@property (nonatomic, readonly) NSArray *array;
@property (nonatomic, readonly) NSUInteger count;

- (void)addModel:(id)model;
- (void)removeModel:(id)model;

- (void)addModels:(NSArray *)models;

- (void)insertModel:(id)model atIndex:(NSUInteger)index;
- (void)removeModelAtIndex:(NSUInteger)index;

- (void)moveModelFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

- (void)updateModel:(id)model;

- (NSUInteger)indexOfModel:(id)model;
- (id)modelAtIndex:(NSUInteger)index;
- (id)objectAtIndexedSubscript:(NSUInteger)idx;

@end
