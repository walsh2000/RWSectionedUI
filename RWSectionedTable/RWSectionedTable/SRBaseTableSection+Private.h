//
//  SRBaseTableSection+Private.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRBaseTableSection.h"

@interface SRBaseTableSection ()


- (UINib *)cellNib;
- (UINib *)footerNib;
- (UINib *)headerNib;

- (NSString *)reuseIdentifier;
- (NSString *)footerReuseIdentifier;
- (NSString *)headerReuseIdentifier;

- (BOOL)isLastRow:(NSInteger)row;
- (BOOL)reloadOnChangeTableEditMode;
- (NSArray *)deleteRowsOnChangeTeableEditMode;
- (NSArray *)insertRowsOnChangeTeableEditMode;

- (id <SRTableSectionDelegate>)tableSectionDelegate;

- (void)removeSeparatorForCell:(UITableViewCell *)cell;
- (void)restoreSeparatorForCell:(UITableViewCell *)cell;
- (void)setSelectionStyleNone:(UITableViewCell *)cell;

- (UIView *)headerViewForTitle:(NSString *)title inTableView:(UITableView *)tableView;
- (UIView *)headerViewForTitle:(NSString *)title inTableView:(UITableView *)tableView leftMargin:(NSInteger)leftMargin separatorMargin:(NSInteger)separatorMargin;

@property (nonatomic, readonly) BOOL tableEditMode;
@end
