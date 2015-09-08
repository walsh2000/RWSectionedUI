//
//  SRSectionedTableViewController.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRSectionedTableViewController : UITableViewController

+ (UINavigationController *)navigationControllerInstance;
+ (instancetype)instantiate;
- (id)initWithTableView:(UITableView *)tableView;

@end
