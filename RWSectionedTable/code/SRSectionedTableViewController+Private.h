//
//  SRSectionedTableViewController+Private.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//
#import "SRSectionedTableViewController.h"
#import "SRTableSection.h"

@class SRSectionedViewControllerHelper;

@interface SRSectionedTableViewController ()  <SRTableSectionDelegate>

+ (NSString *)nibName;

- (void)setupNavBarTitle;
- (void)setupBarButtons;
- (void)setupSections;
- (void)setupTableView;	//should call super
- (void)setupRefreshController;
- (void)reloadSectionData;
- (void)freeSectionData;	//called on viewDidDisappear
- (void)reloadSectionForSectionClass:(Class)c;

- (BOOL)deselectRowOnViewWillAppear;
- (BOOL)deselectRowAfterNotifyingSection;
- (BOOL)wantsRefreshController;//called by super so subclasses can indicate if they want Pull to refresh control
- (void)pullToRefreshTriggered;	//called by super class to let you conduct custom logic
- (void)refreshingDidEnd;	//called by subclasses

//Permit writing to our ViewControllerHelper so we can be a nested view controller
@property (nonatomic, retain) SRSectionedViewControllerHelper *viewControllerHelper;

//Called when removed from the screen (save data & free memory)
//Don't forget to call super
- (void)removedFromParentViewController;

- (void)setTableEditing:(BOOL)editing animated:(BOOL)animated;

//This allows subclasses to use a UISearchController
- (UITableView *)visibleTableView;
- (NSInteger)sectionIndexForSection:(id <SRTableSection>)section;
@property (nonatomic, strong) NSArray *sections;

@end
