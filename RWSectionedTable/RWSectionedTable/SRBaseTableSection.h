//
//  SRBaseTableSection.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRTableSection.h"

@interface SRBaseTableSection : NSObject <SRTableSection>

+ (NSInteger)preferredBlankHeaderHeight;

@end
