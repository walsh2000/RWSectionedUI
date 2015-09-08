//
//  SRTextRowCollectionSectionLayout.m
//  Spark
//
//  Created by Raymond Walsh on 2/28/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRTextRowCollectionSectionLayout.h"

@implementation SRTextRowCollectionSectionLayout

@synthesize layoutMargin;
@synthesize rowHeight;

- (SRCollectionSectionLayoutInfo *)layoutInfoInWidth:(NSInteger)columnWidth withDataSource:(id <SRCollectionDataSource>)source withEdgeInsets:(UIEdgeInsets)insets {
	NSInteger section = [self sectionIndex];
	NSInteger count = [source numberOfItemsFound];
	
	columnWidth -= [self layoutMargin].right + [self layoutMargin].left;
	int rowNumber = 0;
	
	insets.top += [self layoutMargin].top;
	NSInteger heightOfRow = [self rowHeight];
	NSInteger leftOfRow = [self layoutMargin].left;
	
	SRCollectionSectionLayoutInfo *info = [[SRCollectionSectionLayoutInfo alloc] init];
	while (rowNumber < count) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowNumber
													inSection:section];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
		
		NSInteger top = (heightOfRow * rowNumber);
		top += insets.top;
		CGRect frame = CGRectMake(leftOfRow, top, columnWidth, heightOfRow);
		
		frame = CGRectIntegral(frame);
		attributes.frame = frame;
		
		[info addCellAttributes:attributes];
		
		rowNumber++;
	}
	
	[info addBottomMargin:[self layoutMargin].bottom];
	return info;
}

@end
