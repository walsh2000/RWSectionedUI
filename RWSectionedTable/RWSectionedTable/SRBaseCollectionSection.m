//
//  SRBaseCollectionSection.m
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseCollectionDataSource.h"
#import "SRBaseCollectionSection+Private.h"
#import "SRDisabledCollectionSelectionHandler.h"
#import "SRSquareGridCollectionSectionLayout.h"

@implementation SRBaseCollectionSection {
	id <SRCollectionDataSource> _dataSource;
	id <SRCollectionSectionLayout> _layoutHandler;
	id <SRCollectionSelectionHandler> _selectionHandler;
	NSString *_reuseIdentifier;
	NSInteger _sectionIndex;
}

@synthesize collectionSectionDelegate;
@synthesize sectionIndex = _sectionIndex;
@synthesize reuseIdentifier = _reuseIdentifier;
@synthesize dataSource = _dataSource;
@synthesize layoutHandler = _layoutHandler;
@synthesize selectionHandler = _selectionHandler;

- (instancetype)init {
	self = [super init];
	if (self) {
		_reuseIdentifier = NSStringFromClass([self class]);
	}
	return self;
}

#pragma mark - SRCollectionSection

- (void)sectionWillAppear {
	[[self dataSource] reloadData];
}

- (void)sectionDidDisappear {
	[[self dataSource] freeData];
}

- (id <SRCollectionSelectionHandler>)selectionHandler {
	if (_selectionHandler == nil) {
		_selectionHandler = [[SRDisabledCollectionSelectionHandler alloc] init];
	}
	return _selectionHandler;
}

- (id <SRCollectionSectionLayout>)layoutHandler {
	if (_layoutHandler == nil) {
		_layoutHandler = [[SRSquareGridCollectionSectionLayout alloc] init];
	}
	return _layoutHandler;
}

- (id <SRCollectionDataSource>)dataSource {
	if (_dataSource == nil) {
		_dataSource = [[SRBaseCollectionDataSource alloc] init];
		[_dataSource setDataSourceDelegate:self];
	}
	return _dataSource;
}

- (void)setDataSource:(id<SRCollectionDataSource>)dataSource {
	if (_dataSource != dataSource) {
		_dataSource = dataSource;
		[dataSource setDataSourceDelegate:self];
	}
}

- (void)setSectionIndex:(NSInteger)sectionIndex {
	_sectionIndex = sectionIndex;
	[[self layoutHandler] setSectionIndex:(int)sectionIndex];
}

- (BOOL)setupForCollectionView:(UICollectionView *)collectionView {
	UINib *nib = [self collectionViewCellNib];
	if (nib != nil) {
		[collectionView registerNib:nib forCellWithReuseIdentifier:[self reuseIdentifier]];
		return YES;
	} else {
		NSLog(@"**************************************");
		NSLog(@"SRLoopColorCollectionSection: Could not instantiate nib for %@!!", self);
		NSLog(@"**************************************");
	}
	return NO;
}

- (BOOL)shouldHighlightCellAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self reuseIdentifier]
																		   forIndexPath:indexPath];
	[self bindDataAtIndexPath:indexPath toView:cell];
	return cell;
}

#pragma mark - SRCollectionDataSourceDelegate

- (void)dataSourceDidChange:(id<SRCollectionDataSource>)dataSource {
	[[self collectionSectionDelegate] collectionSectionDidChange:self];
}

#pragma mark - Subclassing

- (void)bindDataAtIndexPath:(NSIndexPath *)indexPath toView:(UICollectionViewCell *)cell {
	NSLog(@"**************************************");
	NSLog(@"SRBaseCollectionSection subclasses must overriding \"bindDataAtIndexPath:toView:\" !!");
	NSLog(@"**************************************");
}


- (UINib *)collectionViewCellNib {
	return nil;
}

- (NSString *)reuseIdentifier {
	return NSStringFromClass([self class]);
}


@end
