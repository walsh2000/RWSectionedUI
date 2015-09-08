//
//  SRSectionedTableHeaderView.m
//  Spark
//
//  Created by Raymond Walsh on 4/13/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import "SRSectionedTableHeaderView.h"

@implementation SRSectionedTableHeaderView

@synthesize	headerTextLabel;
@synthesize contentView;
@synthesize separatorView;
@synthesize separatorViewHeightConstraint;
@synthesize headerTextLabelLeftMarginConstraint;

+ (UINib *)nib {
	return [UINib nibWithNibName:@"SRSectionedTableHeaderView" bundle:nil];
}

+ (NSInteger)preferredHeight {
	return 32;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	[[self contentView] setBackgroundColor:[UIColor whiteColor]];
	[[self headerTextLabel] setFont:[UIFont systemFontOfSize:13]];
	[[self headerTextLabel] setTextColor:[UIColor darkGrayColor]];
	[[self separatorView] setBackgroundColor:[UIColor lightGrayColor]];

	CGFloat separatorHeight = (1/[[UIScreen mainScreen] scale]);
	[[self separatorViewHeightConstraint] setConstant:separatorHeight];
}

- (void)removeSeparatorView {
    [[self separatorView] setHidden:YES];
}

@end
