//
//  SRBaseCollectionSelectionHandler.m
//  Spark
//
//  Created by Raymond Walsh on 3/3/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseCollectionSelectionHandler.h"

@implementation SRBaseCollectionSelectionHandler
@synthesize selectionHandlerDelegate;

- (BOOL)handleSelectedObject:(id <NSObject>)object atIndexPath:(NSIndexPath *)indexPath {
	[[self selectionHandlerDelegate] selectionHandler:self didSelectObject:object atIndexPath:indexPath];
	return NO;
}
@end
