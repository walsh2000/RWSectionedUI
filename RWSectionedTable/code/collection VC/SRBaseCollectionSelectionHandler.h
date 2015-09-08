//
//  SRBaseCollectionSelectionHandler.h
//  Spark
//
//  Created by Raymond Walsh on 3/3/15.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRCollectionSelectionHandler.h"

@interface SRBaseCollectionSelectionHandler : NSObject <SRCollectionSelectionHandler>
@property (nonatomic, weak) id <SRCollectionSelectionHandlerDelegate> selectionHandlerDelegate;
@end
