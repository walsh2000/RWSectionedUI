//
//  SRShellSectionedTableViewController.m
//  Spark
//
//  Created by Raymond Walsh on 3/13/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#if HAVE_VGPARALLAXHEADER
#import "UIScrollView+VGParallaxHeader.h"
#endif

#import "SRSectionedTableViewController+Private.h"
#import "SRShellSectionedTableViewController.h"

@interface SRShellSectionedTableViewController ()

@end

@implementation SRShellSectionedTableViewController

@synthesize shellSectionedTableViewControllerDelegate;

- (id)initWithTableView:(UITableView *)tableView sections:(NSArray *)inSections {
	self = [self initWithTableView:tableView];
	if (self) {
		[self setSections:inSections];
		for ( id <SRTableSection> one in [self sections]) {
			[one setTableSectionDelegate:self];
			[one registerWithTableView:[self tableView]];
		}
	}
	return self;
}

- (void)tableSectionDidChange:(id <SRTableSection>)section {
	BOOL handled = NO;
	if ([self shellSectionedTableViewControllerDelegate]) {
		[[self shellSectionedTableViewControllerDelegate] handledTableSectionDidChange:section];
	}
	
	if (!handled) {
		[super tableSectionDidChange:section];
	}
}

#pragma mark - UIScrollViewDelegate

#if HAVE_VGPARALLAXHEADER
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	// This must be called in order to work
	if ([scrollView parallaxHeader]) {
		[scrollView shouldPositionParallaxHeader];
	}
}
#endif

@end
