//
//  SRCollectionSectionLayoutInfo.m
//  Spark
//
//  Created by Raymond Walsh on 12/3/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import "SRCollectionSectionLayoutInfo.h"

@interface SRCollectionSectionLayoutInfo ()
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;
@end

@implementation SRCollectionSectionLayoutInfo {
	NSMutableArray *_attributesForCells;
	NSMutableArray *_attributesForSuppliments;
	NSMutableArray *_attributesForDecorations;
}

@synthesize attributesForCells = _attributesForCells;
@synthesize attributesForSuppliments = _attributesForSuppliments;
@synthesize attributesForDecorations = _attributesForDecorations;
@synthesize bottom;
@synthesize right;

- (id)init {
	self = [super init];
	if (self) {
	}
	return self;
}

- (void)addCellAttributes:(UICollectionViewLayoutAttributes *)attributes {
	if (_attributesForCells == nil) {
		_attributesForCells = [[NSMutableArray alloc] init];
	}
	[_attributesForCells addObject:attributes];
	
	NSInteger maxX = CGRectGetMaxX([attributes frame]);
	if (maxX > right) {
		right = maxX;
	}
	NSInteger maxY = CGRectGetMaxY([attributes frame]);
	if (maxY > bottom) {
		bottom = maxY;
	}
}

- (void)addBottomMargin:(NSInteger)bottomMargin {
	bottom += bottomMargin;
}

- (void)addRightMargin:(NSInteger)rightMargin {
	right += rightMargin;
}

- (void)addSupplimentAttributes:(UICollectionViewLayoutAttributes *)attributes {
	if (_attributesForSuppliments == nil) {
		_attributesForSuppliments = [[NSMutableArray alloc] init];
	}
	[_attributesForSuppliments addObject:attributes];
}

- (void)addDecorationAttributes:(UICollectionViewLayoutAttributes *)attributes {
	if (_attributesForDecorations == nil) {
		_attributesForDecorations = [[NSMutableArray alloc] init];
	}
	[_attributesForDecorations addObject:attributes];
}

@end
