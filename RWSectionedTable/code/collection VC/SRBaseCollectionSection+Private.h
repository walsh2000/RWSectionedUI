//
//  SRBaseCollectionSection+Private.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRBaseCollectionSection.h"

@interface SRBaseCollectionSection () <SRCollectionDataSourceDelegate>

@property (nonatomic, retain) NSString *reuseIdentifier;
@property (nonatomic, weak) id <SRCollectionSectionDelegate> collectionSectionDelegate;

//You must either override or set these to be a good subclass
@property (nonatomic, retain) id <SRCollectionDataSource> dataSource;
@property (nonatomic, retain) id <SRCollectionSectionLayout> layoutHandler;
@property (nonatomic, retain) id <SRCollectionSelectionHandler> selectionHandler;

//You must override these to be a good subclass
- (void)bindDataAtIndexPath:(NSIndexPath *)indexPath toView:(UICollectionViewCell *)cell;
- (UINib *)collectionViewCellNib;
- (NSString *)reuseIdentifier;


@end