//
//  SRArrayCollectionDataSource.m
//  Spark
//
//  Created by Raymond Walsh on 2/28/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRArrayCollectionDataSource.h"

@implementation SRArrayCollectionDataSource {
	NSArray *_array;
}

- (id)initWithArray:(NSArray *)array {
	self = [self init];
	if (self) {
		_array = array;
	}
	return self;
}

#pragma mark - SRCollectionDataSource

- (NSInteger)numberOfItemsFound {
	return [_array count];
}

- (id)objectAtIndex:(NSUInteger)index {
	return [_array objectAtIndex:index];
}


@end
