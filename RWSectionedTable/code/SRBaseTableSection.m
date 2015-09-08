//
//  SRBaseTableSection.m
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import "SRBaseTableSection.h"
#import "SRBaseTableSection+Private.h"
#import "SRRecentConversationsHeaderView.h"
#import "SRTableViewCellSeparatorState.h"


const void *UITableViewHeaderFooterView_AssociationKey = &UITableViewHeaderFooterView_AssociationKey;

@interface SRBaseTableSection ()
@property (nonatomic, weak) id <SRTableSectionDelegate> tableSectionDelegate;
@end

@implementation SRBaseTableSection {
	__weak id <SRTableSectionDelegate> _tableSectionDelegate;
}

@synthesize tableSectionDelegate = _tableSectionDelegate;
@synthesize tableEditMode = _tableEditMode;

#pragma mark - For Subclassing

+ (NSInteger)preferredBlankHeaderHeight {
	return 35;
}

- (UINib *)cellNib {
	return nil;
}

- (UINib *)footerNib {
	return nil;
}

- (UINib *)headerNib {
	return nil;
}

- (NSString *)reuseIdentifier {
	return NSStringFromClass([self class]);
}

- (NSString *)footerReuseIdentifier {
	return [NSStringFromClass([self class]) stringByAppendingString:@"-footer"];
}

- (NSString *)headerReuseIdentifier {
	return [NSStringFromClass([self class]) stringByAppendingString:@"-header"];
}

- (NSString *)defaultHeaderReuseIdentifier {
	return [NSStringFromClass([self class]) stringByAppendingString:@"-default-header"];
}

- (void)removeSeparatorForCell:(UITableViewCell *)cell {
	[cell setSeparatorInset:UIEdgeInsetsMake(0.f, 10000, 0.f, -1000.f)];
}

- (void)restoreSeparatorForCell:(UITableViewCell *)cell {
	[cell setSeparatorInset:UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f)];
}

- (void)setSelectionStyleNone:(UITableViewCell *)cell {
	[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (SRRecentConversationsHeaderView *)headerViewForTitle:(NSString *)title inTableView:(UITableView *)tableView {
    return [self headerViewForTitle:title inTableView:tableView leftMargin:12 separatorMargin:0];
}

- (SRRecentConversationsHeaderView *)headerViewForTitle:(NSString *)title inTableView:(UITableView *)tableView leftMargin:(NSInteger)leftMargin  separatorMargin:(NSInteger)separatorMargin {
	SRRecentConversationsHeaderView *cell = (SRRecentConversationsHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[self defaultHeaderReuseIdentifier]];
	[[cell contentView] setBackgroundColor:[UIColor brandGrayBGColor]];
    [[cell headerTextLabel] setText:title];
    [[cell headerTextLabelLeftMarginConstraint] setConstant:leftMargin];
	
	if (cell) {
		SRTableViewCellSeparatorState *separatorState = [cell associatedObjectForKey:UITableViewHeaderFooterView_AssociationKey];
		if (separatorState == nil) {
			separatorState = [[SRTableViewCellSeparatorState alloc] initWithTableViewHeaderFooterView:cell];
			if (separatorState) {
				[cell associateObject:separatorState withKey:UITableViewHeaderFooterView_AssociationKey];
			}
		}
		[separatorState setMarginWidth:separatorMargin];
	}
	
	return cell;
}

- (BOOL)isLastRow:(NSInteger)row {
	return (row == ([self numberOfRowsInSection]-1));
}

#pragma mark - SRTableSection

- (void)registerWithTableView:(UITableView *)tableView {
	NSString *identifier;
	UINib *nib;
	
	nib = [self cellNib];
	if (nib) {
		identifier = [self reuseIdentifier];
		[tableView registerNib:nib forCellReuseIdentifier:identifier];
	}
	
	nib = [self footerNib];
	if (nib) {
		identifier = [self footerReuseIdentifier];
		[tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
	} else {
		[tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:[self footerReuseIdentifier]];
	}
	
	nib = [self headerNib];
	if (nib) {
		identifier = [self headerReuseIdentifier];
		[tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
	} else {
		identifier = [self defaultHeaderReuseIdentifier];
		nib = [UINib nibWithNibName:@"SRRecentConversationsHeaderView" bundle:nil];
		[tableView registerNib:nib forHeaderFooterViewReuseIdentifier:identifier];
	}
}

- (void)sectionWillAppear {
	[self reloadData];
}

- (void)sectionDidDisappear {
	[self freeMemory];
}

- (void)reloadData {
}

- (void)freeMemory {
}

- (NSInteger)numberOfRowsInSection {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row {
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRow:(NSInteger)row {
	return 44;
}

- (void)didSelectRow:(NSInteger)row {
	return;
}

- (void)didSelectAccessoryForRow:(NSInteger)row {
	return;
}

- (CGFloat)heightForHeader {
	return 0;
}

- (CGFloat)heightForFooter {
	return 0;
}

- (UIView *)viewForHeaderInTableView:(UITableView *)tableView {
	UITableViewHeaderFooterView *cell = (UITableViewHeaderFooterView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:[self headerReuseIdentifier]];
	UIView * view = [[UIView alloc] initWithFrame:cell.bounds];
	view.backgroundColor = [UIColor brandGrayBGColor];
	[cell setBackgroundView:view];
	return cell;
}

- (UIView *)viewForFooterInTableView:(UITableView *)tableView {
	return nil;
}

- (BOOL)canDeleteRow:(NSInteger)row {
	return NO;
}

- (void)deleteItemAtRow:(NSInteger)row {
	NSLog(@"[%@] Subclasses must override this if they expect to delete items", [self class]);
}

- (BOOL)canMoveRow:(NSInteger)row {
	return NO;
}

- (void)moveItemFromSourceRow:(NSInteger)source toDestinationRow:(NSInteger)destination {
	NSLog(@"[%@] Subclasses must override this if they expect to move items", [self class]);
}

- (void)onTableEditModeChanged:(BOOL)editMode {
	if (editMode != _tableEditMode) {
		_tableEditMode = editMode;
		if ([self reloadOnChangeTableEditMode]) {
			[[self tableSectionDelegate] tableSectionDidChange:self];
		} else {
			NSArray *delete = [self deleteRowsOnChangeTeableEditMode];
			for (NSNumber *index in delete) {
				[[self tableSectionDelegate] tableSection:self deleteRow:[index integerValue]];
			}
			NSArray *insert = [self insertRowsOnChangeTeableEditMode];
			for (NSNumber *index in insert) {
				[[self tableSectionDelegate] tableSection:self insertRow:[index integerValue]];
			}
		}
	}
}

- (BOOL)reloadOnChangeTableEditMode {
	return NO;
}

- (NSArray *)deleteRowsOnChangeTeableEditMode {
	return nil;
}

- (NSArray *)insertRowsOnChangeTeableEditMode {
	return nil;
}

- (UITableViewRowAnimation)reloadAnimation {
	return UITableViewRowAnimationAutomatic;
}

- (BOOL)shouldShowMenuForRow:(NSInteger)row {
	return NO;
}

- (BOOL)canPerformAction:(SEL)action forRow:(NSInteger)row {
	return NO;
}

- (void)performAction:(SEL)action forRow:(NSInteger)row {
}

@end
