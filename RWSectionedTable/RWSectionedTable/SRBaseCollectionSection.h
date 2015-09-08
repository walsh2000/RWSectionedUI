//
//  SRBaseCollectionSection.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRCollectionSection.h"

@interface SRBaseCollectionSection : NSObject <SRCollectionSection>
@property (nonatomic, assign) NSInteger sectionIndex;
@end
