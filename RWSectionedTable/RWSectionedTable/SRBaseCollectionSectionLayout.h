//
//  SRBaseCollectionSectionLayout.h
//  Spark
//
//  Created by Raymond Walsh on 12/4/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRCollectionSectionLayout.h"
#import "SRCollectionDataSource.h"

@interface SRBaseCollectionSectionLayout : NSObject <SRCollectionSectionLayout>

@property (nonatomic, assign) UIEdgeInsets layoutMargin;
@property (nonatomic, assign) NSInteger sectionIndex;

@end
