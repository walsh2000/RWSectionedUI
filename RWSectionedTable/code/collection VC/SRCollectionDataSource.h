//
//  SRCollectionDataSource.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SRCollectionDataSource;
@protocol SRCollectionSection;

@protocol SRCollectionDataSourceDelegate
- (void)dataSourceDidChange:(id<SRCollectionDataSource>)dataSource;
@end


@protocol SRCollectionDataSource <NSObject>
/**
    Number of items available. This will determine the largest number you might be asked for in cellForItemAtIndexPath
	You may return 0 or more.
 */
- (NSInteger)numberOfItemsFound;

//Corresponds to the row
- (id)objectAtIndex:(NSUInteger)index;

- (void)setDataSourceDelegate:(id<SRCollectionDataSourceDelegate>)delegate;

//prepare to go offscreen (keep whatever state you need to reload your data)
- (void)freeData;

//refresh whatever cached state you may have
- (void)reloadData;


@end
