//
//  SRSectionedCollectionViewController.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRSectionedCollectionViewController : UICollectionViewController
+ (instancetype)instantiate;
- (id)initWithCollectionView:(UICollectionView *)collectionView;
@end
