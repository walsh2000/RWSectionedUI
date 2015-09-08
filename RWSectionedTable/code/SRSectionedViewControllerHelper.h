//
//  SRSectionedViewControllerHelper.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRSectionedViewControllerHelper : NSObject

- (id)initWithViewController:(UIViewController *)vc;

- (void)pushViewController:(UIViewController *)viewController;
- (void)popViewController:(BOOL)toRoot;
- (void)dismissViewController;
- (void)presentModalViewController:(UIViewController *)viewController;
- (void)presentActionSheet:(UIActionSheet *)sheet;
- (void)presentHUD:(NSString *)title;
- (void)dismissHUD;

@end
