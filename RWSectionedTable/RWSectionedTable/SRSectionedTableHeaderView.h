//
//  SRSectionedTableHeaderView.h
//  Spark
//
//  Created by Raymond Walsh on 4/13/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRSectionedTableHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTextLabelLeftMarginConstraint;
@property (weak, nonatomic) IBOutlet UILabel *headerTextLabel;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *separatorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *separatorViewHeightConstraint;

+ (UINib *)nib;
+ (NSInteger)preferredHeight;

- (void)removeSeparatorView;
@end
