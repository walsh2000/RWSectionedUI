//
//  SRSectionedCollectionViewController.m
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseSectionLayout.h"
#import "SRCollectionSection.h"
#import "SRSectionedCollectionViewController+Private.h"
#import "SRSectionedViewControllerHelper.h"

@interface SRSectionedCollectionViewController () <SRCollectionSectionDelegate>
@end

@implementation SRSectionedCollectionViewController

@synthesize collectionViewSections;
@synthesize viewControllerHelper;

+ (instancetype)instantiate {
	SRSectionedCollectionViewController *vc = [[self alloc] initWithNibName:@"SRSectionedCollectionViewController" bundle:nil];
	[vc setAutomaticallyAdjustsScrollViewInsets:YES];
	[vc setEdgesForExtendedLayout:UIRectEdgeNone];
	return vc;
}

- (id)initWithCollectionView:(UICollectionView *)collectionView {
	self = [super initWithCollectionViewLayout:[self collectionViewLayout]];
	if (self) {
		[self setCollectionView:collectionView];
		[self setup];
		[self setViewControllerHelper:[[SRSectionedViewControllerHelper alloc] initWithViewController:self]];
		
		[[self collectionView] setCollectionViewLayout:[self collectionViewLayout]];
		[[self collectionView] setDataSource:self];
		[[self collectionView] setDelegate:self];
		[[self collectionView] setBackgroundColor:[UIColor whiteColor]];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setup];
	[self setViewControllerHelper:[[SRSectionedViewControllerHelper alloc] initWithViewController:self]];
	
	[[self collectionView] setCollectionViewLayout:[self collectionViewLayout]];
	[[self collectionView] setDataSource:self];
	[[self collectionView] setDelegate:self];
	[[self collectionView] setBackgroundColor:[UIColor whiteColor]];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	for (id <SRCollectionSection> source in [self collectionViewSections]) {
		[source sectionWillAppear];
	}
	[[[self collectionView] collectionViewLayout] invalidateLayout];
	[[self collectionView] reloadData];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	for (id <SRCollectionSection> source in [self collectionViewSections]) {
		[source sectionDidDisappear];
	}
}

#pragma mark - For Subclassing SRSectionedCollectionViewController

- (UICollectionViewLayout *)collectionViewLayout {
	return [[SRBaseSectionLayout alloc] initWithCollectionViewSections:[self collectionViewSections]];
}

- (void)setupCollectionViewSections {
	;
}

- (NSString *)navBarTitle {
	return @"";
}

- (UIBarButtonItem *)leftBarButtonItem {
	return nil;
}

- (UIBarButtonItem *)rightBarButtonItem {
	return nil;
}

- (void)setupNavBarTitle {
	[[self navigationItem] setTitle:[self navBarTitle]];
}

- (void)setupBarButtons {
	UIBarButtonItem *leftButton = [self leftBarButtonItem];
	if (leftButton) {
		[[self navigationItem] setLeftBarButtonItem:leftButton];
	}
	UIBarButtonItem *rightButton = [self rightBarButtonItem];
	if (rightButton) {
		[[self navigationItem] setRightBarButtonItem:rightButton];
	}
}

#pragma mark - SRSectionedCollectionViewController

- (void)setup {
	[self setupBarButtons];
	[self setupNavBarTitle];
	[self setupCollectionViewSections];
	
	int index = 0;
	for (id <SRCollectionSection> source in [self collectionViewSections]) {
		[source setSectionIndex:index++];
		[source setupForCollectionView:[self collectionView]];
		[source setCollectionSectionDelegate:self];
	}
}

#pragma mark - SRCollectionViewController

- (id <SRCollectionSelectionHandler>)selectionHandlerForIndexPath:(NSIndexPath *)indexPath {
	id <SRCollectionSection> section = [[self collectionViewSections] objectAtIndex:[indexPath section]];
	return [section selectionHandler];
}

- (id <SRCollectionDataSource>)dataSourceForIndexPath:(NSIndexPath *)indexPath {
	return [self dataSourceForSection:[indexPath section]];
}

- (id <SRCollectionDataSource>)dataSourceForSection:(NSInteger)section {
	id <SRCollectionSection> searchSection = [[self collectionViewSections] objectAtIndex:section];
	return [searchSection dataSource];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	id <SRCollectionDataSource> dataSource = [self dataSourceForSection:section];
	return [dataSource numberOfItemsFound];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	id <SRCollectionSection> section = [[self collectionViewSections] objectAtIndex:[indexPath section]];
	return [section collectionView:collectionView cellForItemAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return [[self collectionViewSections] count];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	return nil;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	id <SRCollectionSection> section = [[self collectionViewSections] objectAtIndex:[indexPath section]];
	if ([section shouldHighlightCellAtIndexPath:indexPath]) {
		UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
		if (cell) {
			[UIView animateWithDuration:0.1
								  delay:0
								options:(UIViewAnimationOptionAllowUserInteraction)
							 animations:^{
								 [cell setBackgroundColor:[UIColor lightGrayColor]];
							 }
							 completion:nil];
		}
	}
}

- (void)collectionView:(UICollectionView *)collectionView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	id <SRCollectionSection> section = [[self collectionViewSections] objectAtIndex:[indexPath section]];
	if ([section shouldHighlightCellAtIndexPath:indexPath]) {
		UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
		if (cell) {
			[UIView animateWithDuration:0.1
								  delay:0
								options:(UIViewAnimationOptionAllowUserInteraction)
							 animations:^{
								 [cell setBackgroundColor:[UIColor clearColor]];
							 }
							 completion:nil];
		}
	}
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
	
	id <SRCollectionDataSource> dataSource = [self dataSourceForIndexPath:indexPath];
	id object = [dataSource objectAtIndex:[indexPath row]];
	if (object) {
		id <SRCollectionSelectionHandler> handler = [self selectionHandlerForIndexPath:indexPath];
		[handler handleSelectedObject:object atIndexPath:indexPath];
	}
}

#pragma mark - SRCollectionSectionDelegate

- (void)collectionSection:(id <SRCollectionSection>)section reloadItemAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath) {
		[[self collectionView] reloadItemsAtIndexPaths:@[indexPath]];
	}
}

- (void)collectionSectionDidChange:(id<SRCollectionSection>)dataSource {
	[[self collectionView] reloadData];
	[[self collectionView] setNeedsLayout];
}

- (void)collectionSection:(id <SRCollectionSection>)section pushViewController:(UIViewController *)viewController {
	[[self viewControllerHelper] pushViewController:viewController];
}

- (void)collectionSectionPopViewController:(id <SRCollectionSection>)section {
	[[self viewControllerHelper] popViewController:NO];
}
- (void)collectionSectionDismissViewController:(id <SRCollectionSection>)section {
	[[self viewControllerHelper] dismissViewController];
}

- (void)collectionSection:(id <SRCollectionSection>)section presentModalViewController:(UIViewController *)viewController {
	[[self viewControllerHelper] presentModalViewController:viewController];
}

- (void)collectionSection:(id <SRCollectionSection>)section presentHUD:(NSString *)title {
	[[self viewControllerHelper] presentHUD:title];
}

- (void)collectionSection:(id <SRCollectionSection>)section presentActionSheet:(UIActionSheet *)sheet {
	[[self viewControllerHelper] presentActionSheet:sheet];
}

- (void)collectionSectionDismissHUD:(id <SRCollectionSection>)section {
	[[self viewControllerHelper] dismissHUD];
}
@end
