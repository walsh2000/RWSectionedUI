//
//  SRShellSectionedTableViewController.m
//  Spark
//
//  Created by Raymond Walsh on 3/13/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import "UIScrollView+VGParallaxHeader.h"

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

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	// This must be called in order to work
	if ([scrollView parallaxHeader]) {
		[scrollView shouldPositionParallaxHeader];
	}
	
	// scrollView.parallaxHeader.progress - is progress of current scroll
	//	NSLog(@"Progress: %f", scrollView.parallaxHeader.progress);
	//
	//	// This is how you can implement appearing or disappearing of sticky view
	//	[scrollView.parallaxHeader.stickyView setAlpha:scrollView.parallaxHeader.progress];
}

@end
