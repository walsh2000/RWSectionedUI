//
//  SRBaseSectionLayout.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRBaseSectionLayout : UICollectionViewLayout

@property (assign, nonatomic) UIEdgeInsets layoutMargin;

- (id)initWithCollectionViewSections:(NSArray *)layoutSources;

@end
