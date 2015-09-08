//
//  SRSectionedTableHeaderView.m
//  Spark
//
//  Created by Raymond Walsh on 4/13/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
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
	[[self contentView] setBackgroundColor:[UIColor brandWhiteColor]];
	[[self headerTextLabel] setFont:[UIFont systemFontOfSize:13]];
	[[self headerTextLabel] setTextColor:[UIColor brandGray3Color]];
	[[self separatorView] setBackgroundColor:[UIColor brandGray2Color]];

	CGFloat separatorHeight = (1/[[UIScreen mainScreen] scale]);
	[[self separatorViewHeightConstraint] setConstant:separatorHeight];
}

- (void)removeSeparatorView {
    [[self separatorView] setHidden:YES];
}

@end
