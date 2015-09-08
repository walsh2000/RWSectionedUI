//
//  SRCollectionSection.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRCollectionDataSource.h"
#import "SRCollectionSectionLayout.h"
#import "SRCollectionSelectionHandler.h"

@protocol SRCollectionSection;

@protocol SRCollectionSectionDelegate
- (void)collectionSectionDidChange:(id<SRCollectionSection>)section;
- (void)collectionSection:(id <SRCollectionSection>)section presentModalViewController:(UIViewController *)vc;
- (void)collectionSection:(id <SRCollectionSection>)section pushViewController:(UIViewController *)vc;

- (void)collectionSection:(id <SRCollectionSection>)section reloadItemAtIndexPath:(NSIndexPath *)indexPath;

- (void)collectionSectionPopViewController:(id <SRCollectionSection>)section;
- (void)collectionSectionDismissViewController:(id <SRCollectionSection>)section;

- (void)collectionSection:(id <SRCollectionSection>)section presentHUD:(NSString *)title;
- (void)collectionSection:(id <SRCollectionSection>)section presentActionSheet:(UIActionSheet *)sheet;
- (void)collectionSectionDismissHUD:(id <SRCollectionSection>)section;
@end


@protocol SRCollectionSection <NSObject>

- (id <SRCollectionSelectionHandler>)selectionHandler;
- (id <SRCollectionSectionLayout>)layoutHandler;
- (id <SRCollectionDataSource>)dataSource;
- (void)setSectionIndex:(int)index;

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)setupForCollectionView:(UICollectionView *)collectionView;

//return NO to prevent highlighting on taps
- (BOOL)shouldHighlightCellAtIndexPath:(NSIndexPath *)indexPath;

- (void)setCollectionSectionDelegate:(id<SRCollectionSectionDelegate>)delegate;

- (void)sectionWillAppear;
- (void)sectionDidDisappear;

@end
