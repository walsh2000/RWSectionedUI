//
//  SRSquareGridCollectionSectionLayout.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseCollectionSectionLayout.h"

@interface SRSquareGridCollectionSectionLayout : SRBaseCollectionSectionLayout
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, assign) CGFloat cellAspectRatio;
@end
