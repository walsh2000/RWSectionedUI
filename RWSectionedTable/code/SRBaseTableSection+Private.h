//
//  SRBaseTableSection+Private.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRBaseTableSection.h"
#import "SRRecentConversationsHeaderView.h"

@class SRCardRecord;

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

- (SRRecentConversationsHeaderView *)headerViewForTitle:(NSString *)title inTableView:(UITableView *)tableView;
- (SRRecentConversationsHeaderView *)headerViewForTitle:(NSString *)title inTableView:(UITableView *)tableView leftMargin:(NSInteger)leftMargin separatorMargin:(NSInteger)separatorMargin;

@property (nonatomic, readonly) BOOL tableEditMode;
@end
