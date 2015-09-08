//
//  SRBaseCollectionSectionLayout.m
//  Spark
//
//  Created by Raymond Walsh on 12/4/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import "SRBaseCollectionSectionLayout.h"

@implementation SRBaseCollectionSectionLayout

@synthesize layoutMargin = _layoutMargin;
@synthesize sectionIndex = _sectionIndex;

#pragma mark - SRCollectionSectionLayout

- (SRCollectionSectionLayoutInfo *)layoutInfoInWidth:(NSInteger)width withDataSource:(id <SRCollectionDataSource>)source withEdgeInsets:(UIEdgeInsets)insets {
	NSLog( @"*******************************" );
	NSLog( @"SRBaseCollectionSectionLayout -- Subclasses are responsible for implementing this method: %@", NSStringFromSelector(_cmd) );
	NSLog( @"*******************************" );
	return nil;
}

@end
