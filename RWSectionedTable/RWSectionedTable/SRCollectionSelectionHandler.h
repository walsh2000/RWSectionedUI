//
//  SRCollectionSelectionHandler.h
//  Spark
//
//  Created by Raymond Walsh on 2/27/15.
//  Copyright (c) 2015 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SRCollectionSelectionHandler;

@protocol SRCollectionSelectionHandlerDelegate
- (void)selectionHandler:(id <SRCollectionSelectionHandler>)handler didSelectObject:(id <NSObject>)object atIndexPath:(NSIndexPath *)indexPath;
@end

@protocol SRCollectionSelectionHandler <NSObject>

/**
 **	Return whether the item should be deselected
 **	-- You may return NO if you have taken action which will navigate us away from the Search VC
 **	-- You should return YES if you expect to remain on the Search VC (as though you've popped a modal over the Search VC)
 */
- (BOOL)handleSelectedObject:(id <NSObject>)object atIndexPath:(NSIndexPath *)indexPath;

- (void)setSelectionHandlerDelegate:(id <SRCollectionSelectionHandlerDelegate>)delegate;

@end
