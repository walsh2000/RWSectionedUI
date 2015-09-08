//
//  NSObject+Association.h
//  Spark
//
//  Created by Raymond Walsh on 8/27/14.
//  Copyright (c) 2014 Codespeck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Association)

- (void)weakAssociateObject:(id)obj withKey:(const void *)key;
- (void)associateObject:(id)obj withKey:(const void *)key;
- (id)associatedObjectForKey:(const void *)key;

@end
