//
//  SRBaseCollectionDataSource.m
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseCollectionDataSource.h"

@implementation SRBaseCollectionDataSource

@synthesize dataSourceDelegate;

- (NSInteger)numberOfItemsFound {
	return 0;
}

- (id)objectAtIndex:(NSUInteger)index {
	return nil;
}

- (void)freeData {
	;
}

- (void)reloadData {
	;
}

@end
