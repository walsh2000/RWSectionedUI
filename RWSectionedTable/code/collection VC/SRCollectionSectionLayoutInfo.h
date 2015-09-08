//
//  SRCollectionSectionLayoutInfo.h
//  Spark
//
//  Created by Raymond Walsh on 12/3/14.
//  Copyright (c) 2014 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRCollectionSectionLayoutInfo : NSObject

@property (nonatomic, strong, readonly) NSArray *attributesForCells;
@property (nonatomic, strong, readonly) NSArray *attributesForSuppliments;
@property (nonatomic, strong, readonly) NSArray *attributesForDecorations;
@property (nonatomic, assign, readonly) CGFloat bottom;
@property (nonatomic, assign, readonly) CGFloat right;

- (void)addCellAttributes:(UICollectionViewLayoutAttributes *)attributes;
- (void)addSupplimentAttributes:(UICollectionViewLayoutAttributes *)attributes;
- (void)addDecorationAttributes:(UICollectionViewLayoutAttributes *)attributes;

- (void)addBottomMargin:(NSInteger)bottomMargin;
- (void)addRightMargin:(NSInteger)rightMargin;

@end
