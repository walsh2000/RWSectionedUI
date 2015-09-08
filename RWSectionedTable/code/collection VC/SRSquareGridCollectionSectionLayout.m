//
//  SRSquareGridCollectionSectionLayout.m
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRSquareGridCollectionSectionLayout.h"

@implementation SRSquareGridCollectionSectionLayout

@synthesize numberOfColumns;
@synthesize cellAspectRatio;

- (id)init {
	self = [super init];
	if (self) {
		[self setNumberOfColumns:6];
		[self setLayoutMargin:UIEdgeInsetsMake(10, 10, 10, 10)];
		[self setCellAspectRatio:1.0];
	}
	return self;
}

- (SRCollectionSectionLayoutInfo *)layoutInfoInWidth:(NSInteger)width withDataSource:(id <SRCollectionDataSource>)source withEdgeInsets:(UIEdgeInsets)insets {
	NSInteger section = [self sectionIndex];
	NSInteger count = [source numberOfItemsFound];
	
	width -= [self layoutMargin].right + [self layoutMargin].left;
	NSInteger columnWidth = (width / [self numberOfColumns]);
	NSInteger columnHeight = ((CGFloat)columnWidth * [self cellAspectRatio]);
	int columnNumber = 0;
	int rowNumber = 0;
	
	insets.top += [self layoutMargin].top;
	
	SRCollectionSectionLayoutInfo *info = [[SRCollectionSectionLayoutInfo alloc] init];
	int  columnCount = (int)[self numberOfColumns];
	int itemIndex = 0;
	while (itemIndex < count) {
		NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex
													inSection:section];
		UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
		
		NSInteger left = (columnWidth * columnNumber);
		NSInteger top = (columnHeight * rowNumber);
		left += [self layoutMargin].left;
		top += insets.top;
		CGRect frame = CGRectMake(left, top, columnWidth, columnHeight);
		
		frame = CGRectIntegral(frame);
		attributes.frame = frame;
		
		[info addCellAttributes:attributes];
		
		columnNumber++;
		if (columnNumber == columnCount) {
			columnNumber = 0;
			rowNumber++;
		}
		itemIndex++;
	}

	[info addBottomMargin:[self layoutMargin].bottom];
	[info addRightMargin:[self layoutMargin].right];

	return info;
}

@end
