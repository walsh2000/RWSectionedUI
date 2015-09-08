//
//  SRTableSection.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRSectionedTableHeaderView.h"

@protocol SRTableSection;

@protocol SRTableSectionDelegate <NSObject>

- (void)tableSectionDidChange:(id <SRTableSection>)section;
- (void)tableSection:(id <SRTableSection>)section pushViewController:(UIViewController *)viewController;
- (void)tableSection:(id <SRTableSection>)section presentModalViewController:(UIViewController *)viewController;
- (void)tableSection:(id <SRTableSection>)section reloadRow:(NSInteger)index;
- (void)tableSection:(id <SRTableSection>)section deleteRow:(NSInteger)index;
- (void)tableSection:(id <SRTableSection>)section insertRow:(NSInteger)index;

//This view controller is effectively done, we should leave (UINavigationController should pop. Modal should dismiss)
- (void)tableSectionPopViewController:(id <SRTableSection>)section toRoot:(BOOL)popToRoot;
- (void)tableSectionDismissViewController:(id <SRTableSection>)section;

- (void)tableSection:(id <SRTableSection>)section presentHUD:(NSString *)title;
- (void)tableSection:(id <SRTableSection>)section presentActionSheet:(UIActionSheet *)sheet;
- (void)tableSectionDismissHUD:(id <SRTableSection>)section;
@end


@protocol SRTableSection <NSObject>

- (void)registerWithTableView:(UITableView *)tableView;
- (void)reloadData;
- (void)freeMemory;
- (void)sectionWillAppear;
- (void)sectionDidDisappear;
- (NSInteger)numberOfRowsInSection;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRow:(NSInteger)row;
- (CGFloat)tableView:(UITableView *)tableView heightForRow:(NSInteger)row;
- (void)didSelectRow:(NSInteger)row;
- (void)didSelectAccessoryForRow:(NSInteger)row;
- (void)setTableSectionDelegate:(id <SRTableSectionDelegate>)delegate;

- (CGFloat)heightForHeader;
- (CGFloat)heightForFooter;
- (SRSectionedTableHeaderView *)viewForHeaderInTableView:(UITableView *)tableView;
- (SRSectionedTableHeaderView *)viewForFooterInTableView:(UITableView *)tableView;

- (BOOL)canDeleteRow:(NSInteger)row;
- (void)deleteItemAtRow:(NSInteger)row;

- (BOOL)canMoveRow:(NSInteger)row;
- (void)moveItemFromSourceRow:(NSInteger)source toDestinationRow:(NSInteger)destination;

- (void)onTableEditModeChanged:(BOOL)editMode;
- (UITableViewRowAnimation)reloadAnimation;

- (BOOL)shouldShowMenuForRow:(NSInteger)row;
- (BOOL)canPerformAction:(SEL)action forRow:(NSInteger)row;
- (void)performAction:(SEL)action forRow:(NSInteger)row;
@end
