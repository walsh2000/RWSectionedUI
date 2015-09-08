//
//  SRCollectionSectionLayout.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRCollectionDataSource.h"
#import "SRCollectionSectionLayoutInfo.h"

@protocol SRCollectionSectionLayout <NSObject>

//Set the "top" to where the top element should be
//left & right can control edge margins
//bottom is ignored
//** You will not be called if your section has zero elements
- (SRCollectionSectionLayoutInfo *)layoutInfoInWidth:(NSInteger)width withDataSource:(id <SRCollectionDataSource>)source withEdgeInsets:(UIEdgeInsets)insets;
- (void)setSectionIndex:(int)sectionIndex;

@end
