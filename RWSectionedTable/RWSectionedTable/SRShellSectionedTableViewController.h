//
//  SRShellSectionedTableViewController.h
//  Spark
//
//  Created by Raymond Walsh on 3/13/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRSectionedTableViewController.h"

@protocol SRShellSectionedTableViewControllerDelegate <NSObject>
- (BOOL)handledTableSectionDidChange:(id <SRTableSection>)section;
@end


@interface SRShellSectionedTableViewController : SRSectionedTableViewController
- (id)initWithTableView:(UITableView *)tableView sections:(NSArray *)inSections;

@property (nonatomic, weak) id <SRShellSectionedTableViewControllerDelegate>  shellSectionedTableViewControllerDelegate;
@end
