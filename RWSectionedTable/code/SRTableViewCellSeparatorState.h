//
//  SRTableViewCellSeparatorState.h
//  Spark
//
//  Created by Raymond Walsh on 6/12/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRTableViewCellSeparatorState : NSObject

- (id)initWithTableViewCell:(UITableViewCell *)cell;
- (id)initWithTableViewHeaderFooterView:(UITableViewHeaderFooterView *)view;

- (void)setMarginWidth:(NSInteger)width;
@end
