//
//  SRTableViewCellSeparatorState.h
//  Spark
//
//  Created by Raymond Walsh on 6/12/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Association.h"

@interface SRTableViewCellSeparatorState : NSObject

- (id)initWithTableViewCell:(UITableViewCell *)cell;
- (id)initWithTableViewHeaderFooterView:(UITableViewHeaderFooterView *)view;

- (void)setMarginWidth:(NSInteger)width;
@end
