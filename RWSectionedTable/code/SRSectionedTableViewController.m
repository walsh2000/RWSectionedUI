//
//  SRSectionedTableViewController.m
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import <MBProgressHUD.h>
#import "SRSectionedTableViewController+Private.h"
#import "SRSectionedViewControllerHelper.h"
#import "SRTableSection.h"

@interface SRSectionedTableViewController ()
@end

@implementation SRSectionedTableViewController {
	NSArray *_sections;
	MBProgressHUD *_sectionHUD;
	UIRefreshControl *_refreshControl;
}

@synthesize sections = _sections;
@synthesize viewControllerHelper;

#pragma mark - Private for Subclasses

+ (NSString *)nibName {
	return @"SRSectionedTableViewController";
}

+ (instancetype)instantiate {
	return [[self alloc] initWithNibName:[self nibName] bundle:nil];
}

- (id)initWithTableView:(UITableView *)tableView {
	self = [super initWithStyle:UITableViewStylePlain];
	if (self) {
		[self setTableView:tableView];
		[[self tableView] setDelegate:self];
		[[self tableView] setDataSource:self];
		[self setupTableView];
		[self setupSections];
		[self setViewControllerHelper:[[SRSectionedViewControllerHelper alloc] initWithViewController:self]];
		[self setupRefreshController];
	}
	return self;
}

#pragma mark - Public

+ (UINavigationController *)navigationControllerInstance {
	UIViewController *viewController = [self instantiate];

	return [[UINavigationController alloc] initWithRootViewController:viewController];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self setupTableView];
	[self setupSections];
	[self setupBarButtons];
	[self setupNavBarTitle];
	[self setViewControllerHelper:[[SRSectionedViewControllerHelper alloc] initWithViewController:self]];
	[self setupRefreshController];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self sectionsWillAppear];
	[[self visibleTableView] reloadData];
	if ([self deselectRowOnViewWillAppear]) {
		NSIndexPath *path = [[self tableView] indexPathForSelectedRow];
		if (path) {
			[[self tableView] deselectRowAtIndexPath:[[self tableView] indexPathForSelectedRow] animated:NO];
		}
	}
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self sectionsDidDisappear];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	[self freeSectionData];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
	[super didMoveToParentViewController:parent];
	if (parent == nil) {
		[self removedFromParentViewController];
	}
}

#pragma mark - Private

- (void)pullToRefreshTriggered {
	[self refreshingDidEnd];
}

- (void)refreshingDidEnd {
	[[self refreshControl] endRefreshing];
}

- (void)refreshTriggeredByRefreshControl:(id)sender {
	[self pullToRefreshTriggered];
}

- (BOOL)wantsRefreshController {
	return NO;
}

- (BOOL)deselectRowOnViewWillAppear {
	return YES;
}

- (BOOL)deselectRowAfterNotifyingSection {
	return YES;
}

- (void)setupRefreshController {
	if ([self wantsRefreshController]) {
		if (_refreshControl == nil) {
			_refreshControl = [[UIRefreshControl alloc] init];
			
			// Configure Refresh Control
			[_refreshControl addTarget:self
								action:@selector(refreshTriggeredByRefreshControl:)
					  forControlEvents:UIControlEventValueChanged
			 ];
			
			// Configure View Controller
			[self setRefreshControl:_refreshControl];
		}
	}
}
- (void)setupNavBarTitle {
}

- (void)setupBarButtons {
}

- (void)setupTableView {
	[[self tableView] setKeyboardDismissMode:UIScrollViewKeyboardDismissModeOnDrag];
	//This eliminates separators for the Empty Cells (below all content)
	[[self tableView] setTableFooterView:[[UIView alloc] init]];
	//Eliminiates all separators
	[[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)setupSections {
	[self setSections:@[]];
}

- (NSInteger)sectionIndexForSection:(id <SRTableSection>)section {
	NSInteger index = 0;
	for (id <SRTableSection> one in [self sections]) {
		if (one == section) {
			return index;
		}
		index ++;
	}
	return NSNotFound;
}

- (void)sectionsWillAppear {
	for (id <SRTableSection> one in [self sections]) {
		[one sectionWillAppear];
	}
}

- (void)sectionsDidDisappear {
	for (id <SRTableSection> one in [self sections]) {
		[one sectionDidDisappear];
	}
}

- (void)reloadSectionData {
	for (id <SRTableSection> one in [self sections]) {
		[one reloadData];
	}
}

- (void)reloadSectionForSectionClass:(Class)c {
	int sectionIndex = 0;
	for (id <SRTableSection> one in [self sections]) {
		if ([one isKindOfClass:c]) {
			[one reloadData];
			NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
			[[self tableView] reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
		}
		sectionIndex++;
	}
}

- (void)freeSectionData {
	for (id <SRTableSection> one in [self sections]) {
		[one freeMemory];
	}
}

- (void)setTableEditing:(BOOL)editing animated:(BOOL)animated {
	[CATransaction begin];
	for (id <SRTableSection> one in [self sections]) {
		[one onTableEditModeChanged:editing];
	}
	[[self tableView] setEditing:editing animated:animated];
	[CATransaction commit];
}

- (UITableView *)visibleTableView {
	return [self tableView];
}

- (void)removedFromParentViewController {
	[self freeSectionData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return [[self sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:section];
	return [sectionHandler numberOfRowsInSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	UITableViewCell *cell = [sectionHandler tableView:[self tableView] cellForRow:[indexPath row]];
	if (cell == nil) {
		NSLog(@"Section failed to produce a cell: [IndexPath: %@] [Section: %@]", indexPath, sectionHandler);
	}
	return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	return [sectionHandler canMoveRow:[indexPath row]] || [sectionHandler canDeleteRow:[indexPath row]];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	return [sectionHandler canMoveRow:[indexPath row]];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	if ([sectionHandler canDeleteRow:[indexPath row]]) {
		return UITableViewCellEditingStyleDelete;
	} else {
		return UITableViewCellEditingStyleNone;
	}
}

//limit the destination to the same section
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)source toProposedIndexPath:(NSIndexPath *)destination {
	if ([source section] != [destination section]) {
		NSInteger row = 0;
		if ([source section] < [destination section]) {
			row = [tableView numberOfRowsInSection:[source section]] - 1;
		}
		return [NSIndexPath indexPathForRow:row inSection:[source section]];
	}
	
	return destination;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)source toIndexPath:(NSIndexPath *)destination {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[source section]];
	[sectionHandler moveItemFromSourceRow:[source row] toDestinationRow:[destination row]];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
		[sectionHandler deleteItemAtRow:[indexPath row]];
	}
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	[sectionHandler didSelectRow:[indexPath row]];
	if ([self deselectRowAfterNotifyingSection]) {
		[tableView deselectRowAtIndexPath:indexPath animated:YES];
	}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	[sectionHandler didSelectAccessoryForRow:[indexPath row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:section];
	return [sectionHandler heightForHeader];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:section];
	return [sectionHandler heightForFooter];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:section];
	return [sectionHandler viewForHeaderInTableView:[self tableView]];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:section];
	return [sectionHandler viewForFooterInTableView:[self tableView]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	return [sectionHandler tableView:[self tableView] heightForRow:[indexPath row]];
}

- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	return [sectionHandler shouldShowMenuForRow:[indexPath row]];
}

- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	return [sectionHandler canPerformAction:action forRow:[indexPath row]];
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	id <SRTableSection> sectionHandler = [[self sections] objectAtIndex:[indexPath section]];
	return [sectionHandler performAction:action forRow:[indexPath row]];
}
#pragma mark - SRTableSectionDelegate

- (void)tableSection:(id <SRTableSection>)section reloadRow:(NSInteger)row {
	NSInteger sectionIndex = [self sectionIndexForSection:section];
	if (sectionIndex != NSNotFound) {
		if ([section numberOfRowsInSection] > row) {
			if ([[self visibleTableView] numberOfSections] > sectionIndex) {
				NSInteger numberOfRowsInSection = [[self visibleTableView] numberOfRowsInSection:sectionIndex];
				if (numberOfRowsInSection > row) {
					[[Crashlytics sharedInstance] setObjectValue:@(numberOfRowsInSection) forKey:@"Reload-NumberOfRowsInSection"];
					[[Crashlytics sharedInstance] setObjectValue:@([section numberOfRowsInSection]) forKey:@"Reload-NumberOfRowsInSection-Section"];
					[[Crashlytics sharedInstance] setObjectValue:@(row) forKey:@"Reload-Row"];
					if (numberOfRowsInSection != [section numberOfRowsInSection]) {
						[[Crashlytics sharedInstance] setObjectValue:NSStringFromClass([self class]) forKey:@"Reload-VC-Class"];
						[[Crashlytics sharedInstance] setObjectValue:NSStringFromClass([section class]) forKey:@"Reload-Section-Class"];
						/**
						 **	It appears to me that this is happening because a row moves from section 3 to section 0 (as when a week-old chat becomes a today chat)
						 ** We reload the today section, and that cause the table to interrogate the past-week section and finds that a cell is missing
						 **	This is causing a crash: COD-1032 [Crash] reloading conversation list
						 ** My solution is to reload the whole table when we encounter a row-count mismatch
						 **	This will cause an unnecessary table reload when a new conversation arrives (in today), however
						 ** the more common case of a yesterday chat jumping to today does require the reload to prevent the crash
						 */
						[[self visibleTableView] reloadData];
					} else {
						[[self visibleTableView] reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:sectionIndex]] withRowAnimation:UITableViewRowAnimationNone];
					}
					[[Crashlytics sharedInstance] setObjectValue:nil forKey:@"Reload-NumberOfRowsInSection"];
					[[Crashlytics sharedInstance] setObjectValue:nil forKey:@"Reload-NumberOfRowsInSection-Section"];
					[[Crashlytics sharedInstance] setObjectValue:nil forKey:@"Reload-Row"];
				} else {
				}
			} else {
			}
		} else {
			NSLog( @"A section tried to reload a row which was out of bounds! -- %@", section);
		}
	}
}

- (void)tableSection:(id <SRTableSection>)section deleteRow:(NSInteger)row {
	NSInteger sectionIndex = [self sectionIndexForSection:section];
	if (sectionIndex != NSNotFound) {
		if ([section numberOfRowsInSection] >= row) {
			if ([[self visibleTableView] numberOfSections] > sectionIndex) {
				NSInteger numberOfRowsInSection = [[self visibleTableView] numberOfRowsInSection:sectionIndex];
				if (numberOfRowsInSection > row) {
					[[Crashlytics sharedInstance] setObjectValue:@(numberOfRowsInSection) forKey:@"Delete-NumberOfRowsInSection"];
					[[Crashlytics sharedInstance] setObjectValue:@(row) forKey:@"Delete-Row"];
					[[self visibleTableView] deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:sectionIndex]] withRowAnimation:[section reloadAnimation]];
					[[Crashlytics sharedInstance] setObjectValue:nil forKey:@"Delete-NumberOfRowsInSection"];
					[[Crashlytics sharedInstance] setObjectValue:nil forKey:@"Delete-Row"];
				} else {
				}
			} else {
			}
		} else {
			NSLog( @"A section tried to delete a row which was out of bounds! -- %@", section);
		}
	}
}

- (void)tableSection:(id <SRTableSection>)section insertRow:(NSInteger)row {
	NSInteger sectionIndex = [self sectionIndexForSection:section];
	if (sectionIndex != NSNotFound) {
		[[self visibleTableView] insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:sectionIndex]] withRowAnimation:[section reloadAnimation]];
	}
}

- (void)tableSectionDidChange:(id <SRTableSection>)section {
	NSInteger sectionIndex = [self sectionIndexForSection:section];
	if (sectionIndex != NSNotFound) {
		NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
		[[self visibleTableView] reloadSections:set withRowAnimation:[section reloadAnimation]];
	}
}

- (void)tableSection:(id <SRTableSection>)section pushViewController:(UIViewController *)viewController {
	[[self viewControllerHelper] pushViewController:viewController];
}

- (void)tableSectionPopViewController:(id <SRTableSection>)section toRoot:(BOOL)popToRoot {
	[[self viewControllerHelper] popViewController:popToRoot];
}
- (void)tableSectionDismissViewController:(id <SRTableSection>)section {
	[[self viewControllerHelper] dismissViewController];
}

- (void)tableSection:(id <SRTableSection>)section presentModalViewController:(UIViewController *)viewController {
	[[self viewControllerHelper] presentModalViewController:viewController];
}

- (void)tableSection:(id <SRTableSection>)section presentHUD:(NSString *)title {
	[[self viewControllerHelper] presentHUD:title];
}

- (void)tableSection:(id <SRTableSection>)section presentActionSheet:(UIActionSheet *)sheet {
	[[self viewControllerHelper] presentActionSheet:sheet];
}

- (void)tableSectionDismissHUD:(id <SRTableSection>)section {
	[[self viewControllerHelper] dismissHUD];
}


@end
