//
//  SRBaseSectionLayout.m
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseSectionLayout.h"
#import "SRCollectionSection.h"

@interface SRBaseSectionLayout ()

@property (nonatomic, strong) NSDictionary *layoutAttributes;
@property (nonatomic, strong) NSArray *collectionViewSections;

@end

@implementation SRBaseSectionLayout {
	CGSize _contentSize;
}

@synthesize layoutMargin = _layoutMargin;
@synthesize layoutAttributes = _layoutAttributes;
@synthesize collectionViewSections = _collectionViewSections;

- (id)initWithCollectionViewSections:(NSArray *)sections {
	self = [self init];
	if (self) {
		self.layoutMargin = UIEdgeInsetsMake(20.0, 0.0, 0.0, 0.0);
		self.collectionViewSections = sections;
	}
	
	return self;
}

#pragma mark - Accessors

- (void)setLayoutMargin:(UIEdgeInsets)margins {
	
	if (!UIEdgeInsetsEqualToEdgeInsets(margins, [self layoutMargin])) {
		
		_layoutMargin = margins;
		
		[self invalidateLayout];
	}
}

- (void)setCollectionViewSections:(NSArray *)sources {
	
	if (sources != self.collectionViewSections) {
		
		_collectionViewSections = sources;
		
		[self invalidateLayout];
	}
}

#pragma mark - Layout computation

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
	
	return YES;
}

- (CGSize)collectionViewContentSize {
	return _contentSize;
}

- (void)prepareLayout {
	
	CGSize maxSize = CGSizeZero;
	NSMutableDictionary *computeAttributes = [NSMutableDictionary dictionary];
	UIEdgeInsets insets = self.layoutMargin;
	
	NSInteger count;
	NSInteger width = [[self collectionView] frame].size.width;
	NSInteger maxY = 0;
	NSInteger maxX = [[self collectionView] frame].size.width;
	
	for (id <SRCollectionSection> section in [self collectionViewSections] ) {
		count = [[section dataSource] numberOfItemsFound];
		if (count) {
			SRCollectionSectionLayoutInfo *infos = [[section layoutHandler] layoutInfoInWidth:width
																			   withDataSource:[section dataSource]
																			   withEdgeInsets:insets
													];
			if (infos) {
				insets.top = [infos bottom];
				if (maxX < [infos right]) {
					maxX = [infos right];
				}
				if (maxY < [infos bottom]) {
					maxY = [infos bottom];
				}
				insets.top = maxY;
				for (UICollectionViewLayoutAttributes *attributes in [infos attributesForCells]) {
					NSIndexPath *indexPath = [attributes indexPath];
					computeAttributes[indexPath] = attributes;
				}
			}
		}
	}
	maxSize.height = maxY;
	maxSize.width = maxX;	//[[self collectionView] frame].size.width;
	
	self.layoutAttributes = computeAttributes;
	_contentSize = maxSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
	
	NSMutableArray *outAttributes = [NSMutableArray array];
	
	[self.layoutAttributes enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath, UICollectionViewLayoutAttributes *attributes, BOOL *stop) {
		
		if (CGRectIntersectsRect(rect, attributes.frame)) {
			
			[outAttributes addObject:attributes];
		}
	}];
	
	return outAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	return self.layoutAttributes[indexPath];
}

@end
