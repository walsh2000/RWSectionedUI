//
//  SRSectionedViewControllerHelper.m
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import "MBProgressHUD.h"
#import "SRSectionedViewControllerHelper.h"

@interface SRSectionedViewControllerHelper ()
@property (nonatomic, weak) UIViewController *viewController;
@end

@implementation SRSectionedViewControllerHelper {
	MBProgressHUD *_sectionHUD;
}

@synthesize viewController = _viewController;

- (id)initWithViewController:(UIViewController *)vc {
	self = [self init];
	if (self) {
		[self setViewController:vc];
	}
	return self;
}

- (void)pushViewController:(UIViewController *)viewController {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		[_viewController.navigationController pushViewController:viewController animated:YES];
	});
}

- (void)popViewController:(BOOL)toRoot {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if (toRoot) {
			[_viewController.navigationController popToRootViewControllerAnimated:YES];
		} else {
			[_viewController.navigationController popViewControllerAnimated:YES];
		}
	});
}
- (void)dismissViewController {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		[[_viewController presentingViewController] dismissViewControllerAnimated:YES completion:nil];
	});
}

- (void)presentModalViewController:(UIViewController *)viewController {
	dispatch_async(dispatch_get_main_queue(), ^(void) {
		if ([_viewController navigationController]) {
			[[_viewController navigationController] presentViewController:viewController animated:YES completion:nil];
		} else {
			[_viewController presentViewController:viewController animated:YES completion:nil];
		}
	});
}

- (void)presentHUD:(NSString *)title {
	if (_sectionHUD == nil) {
		[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
		_sectionHUD = [[MBProgressHUD alloc] initWithView:[_viewController view]];
		[_sectionHUD setTaskInProgress:YES];
		[_sectionHUD setGraceTime:0.15];
		[_sectionHUD setRemoveFromSuperViewOnHide:YES];
		[[[_viewController view] window] addSubview:_sectionHUD];
		[_sectionHUD show:YES];
		
	}
	[_sectionHUD setLabelText:title];
}

- (void)presentActionSheet:(UIActionSheet *)sheet {
	[sheet showInView:[_viewController view]];
}

- (void)dismissHUD {
	if (_sectionHUD) {
		[[UIApplication sharedApplication] endIgnoringInteractionEvents];
		[_sectionHUD setTaskInProgress:NO];
		[_sectionHUD hide:YES];
		_sectionHUD = nil;
	}
}
@end
