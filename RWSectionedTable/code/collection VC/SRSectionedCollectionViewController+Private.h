//
//  SRSectionedCollectionViewController+Private.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRSectionedCollectionViewController.h"

@class SRSectionedViewControllerHelper;

@interface SRSectionedCollectionViewController()

@property (nonatomic, retain) NSArray *collectionViewSections;
@property (nonatomic, retain) SRSectionedViewControllerHelper *viewControllerHelper;


//If you need to setup the buttons differently than just returning an item for left & right
- (void)setupBarButtons;

//If you need to setup the buttons differently than just returning a string for the title
- (void)setupNavBarTitle;

//Setup collectionViewSections
//setupForCollectionView is called for you automatically after you have setup collectionViewSections
//The data source delegate is set after returning from this function
- (void)setupCollectionViewSections;

//Simple setup methods
- (UIBarButtonItem *)leftBarButtonItem;
- (UIBarButtonItem *)rightBarButtonItem;
- (NSString *)navBarTitle;

//This is called after the setup functions
//A compatible layout is returned (SRBaseSectionLayout) if you do not override this
- (UICollectionViewLayout *)collectionViewLayout;

@end