//
//  NSMutableArray+YMExtension.m
//  ImageViewer
//
//  Created by Yurii Mamurko on 1/8/18.
//  Copyright © 2018 Yurii Mamurko. All rights reserved.
//

#import "NSMutableArray+YMExtension.h"

@implementation NSMutableArray (YMExtension)

- (void)moveObjectFromIndex:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex {
	id object = [self objectAtIndex:fromIndex];

	[self removeObjectAtIndex:fromIndex];
	[self insertObject:object atIndex:toIndex];
}

@end
