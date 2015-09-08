//
//  SRBaseTableSection.h
//  Spark
//
//  Created by Raymond Walsh on 12/16/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRTableSection.h"

@class SRConversationRecord;

@interface SRBaseTableSection : NSObject <SRTableSection>

+ (NSInteger)preferredBlankHeaderHeight;

@end
