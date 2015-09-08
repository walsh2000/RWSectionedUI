//
//  SRBaseCollectionDataSource.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRCollectionDataSource.h"

@interface SRBaseCollectionDataSource : NSObject <SRCollectionDataSource>

@property (nonatomic, weak) id <SRCollectionDataSourceDelegate> dataSourceDelegate;
@end
