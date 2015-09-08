//
//  SRTableViewCellSeparatorState.m
//  Spark
//
//  Created by Raymond Walsh on 6/12/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import "SRTableViewCellSeparatorState.h"

@interface SRTableViewCellSeparatorState ()
@property (nonatomic, weak) UITableViewCell *containingCell;
@property (nonatomic, weak) UITableViewHeaderFooterView *containingHeaderFooterView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) NSLayoutConstraint *leftMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint *rightMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint *bottomMarginConstraint;
@property (nonatomic, strong) NSLayoutConstraint *separatorHeightConstraint;
@end

@implementation SRTableViewCellSeparatorState

@synthesize containingCell;
@synthesize containingHeaderFooterView;
@synthesize separatorView;
@synthesize leftMarginConstraint;
@synthesize rightMarginConstraint;
@synthesize bottomMarginConstraint;
@synthesize separatorHeightConstraint;

- (id)initWithTableViewCell:(UITableViewCell *)cell {
	self = [self init];
	if (self) {
		[self setContainingCell:cell];
		[self setupSeparatorView];
		[[[self containingCell] contentView] addSubview:[self separatorView]];
		
		[self setupConstraints];
	}
	return self;
}

- (id)initWithTableViewHeaderFooterView:(UITableViewHeaderFooterView *)view {
	if (view) {
		self = [self init];
		if (self) {
			[self setContainingHeaderFooterView:view];
			[self setupSeparatorView];
			[[[self containingHeaderFooterView] contentView] addSubview:[self separatorView]];
			
			[self setupConstraints];
		}
	} else {
		self = nil;
	}
	return self;
}

- (void)setupSeparatorView {
	[self setSeparatorView:[[UIView alloc] init]];
	[separatorView setBackgroundColor:[UIColor brandGray2Color]];
}

- (void)setupConstraints {
	[[self separatorView] setTranslatesAutoresizingMaskIntoConstraints:NO];

	bottomMarginConstraint =
	[NSLayoutConstraint constraintWithItem:separatorView
								 attribute:NSLayoutAttributeBottom
								 relatedBy:NSLayoutRelationEqual
									toItem:[self containerView]
								 attribute:NSLayoutAttributeBottom
								multiplier:1
								  constant:0];
	
	leftMarginConstraint =
	[NSLayoutConstraint constraintWithItem:separatorView
								 attribute:NSLayoutAttributeLeft
								 relatedBy:NSLayoutRelationEqual
									toItem:[self containerView]
								 attribute:NSLayoutAttributeLeft
								multiplier:1
								  constant:0];
	rightMarginConstraint =
	[NSLayoutConstraint constraintWithItem:separatorView
								 attribute:NSLayoutAttributeRight
								 relatedBy:NSLayoutRelationEqual
									toItem:[self containerView]
								 attribute:NSLayoutAttributeRight
								multiplier:1
								  constant:0];
	
	CGFloat separatorHeight = (1/[[UIScreen mainScreen] scale]);
	separatorHeightConstraint =
	[NSLayoutConstraint constraintWithItem:separatorView
								 attribute:NSLayoutAttributeHeight
								 relatedBy:NSLayoutRelationEqual
									toItem:nil
								 attribute:NSLayoutAttributeNotAnAttribute
								multiplier:1
								  constant:separatorHeight];
	
	
	[separatorView addConstraints:@[
									separatorHeightConstraint
									]];
	
	[[self containerView] addConstraints:@[
										   leftMarginConstraint,
										   rightMarginConstraint,
										   bottomMarginConstraint
										   ]];
}

- (UIView *)containerView {
	return [self containingCell]?:[self containingHeaderFooterView];
}

- (void)setMarginWidth:(NSInteger)width {
	if (width != [[self leftMarginConstraint] constant]) {
		[[self leftMarginConstraint] setConstant:width];
	}
}

@end
