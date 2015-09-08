//
//  SRContentSearchDataSource.m
//  Spark
//
//  Created by Raymond Walsh on 12/5/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//
#import "SRAuthenticatedUser.h"
#import "SRUserImages.h"
#import "SRContentSearchDataSource.h"
#import "SRConversationManager.h"
#import "SRConversationContentRecord.h"
#import "SRFilteredConversationContentResultSet.h"
#import "SRIconLabelCell.h"

@implementation SRContentSearchDataSource

#pragma mark - SRSearchDataSource

- (void)startSearching:(NSString *)query {
	__weak SRContentSearchDataSource *weakSelf = self;
	[self stopSearching];
	//This is captured in the block & helps us determine if our current search has been cancelled
	NSUInteger searchRequestId = [self searchRequestId];
	[self runSearchBlock:^{
		@autoreleasepool {
			SRContentSearchDataSource *strongSelf = weakSelf;
			if (strongSelf) {
				SRFilteredConversationContentResultSet *resultSet = nil;
				if ([query length] > 1) {
					NSString *sqlQuery = [[@"%" stringByAppendingString:query] stringByAppendingString:@"%"];
					resultSet = [[SRConversationManager manager] conversationContentMatching:sqlQuery];
				}
				[strongSelf setResultSet:resultSet searchRequestId:searchRequestId];
			}
		}
	}];
}

@end
