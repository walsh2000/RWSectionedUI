//
//  NSObject+Association.m
//  Spark
//
//  Created by Raymond Walsh on 8/27/14.
//  Copyright (c) 2015 Raymond Walsh. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+Association.h"

@implementation NSObject (Association)

- (void)weakAssociateObject:(id)obj withKey:(const void *)key {
	objc_setAssociatedObject(self, key, obj, OBJC_ASSOCIATION_ASSIGN);
}

- (void)associateObject:(id)obj withKey:(const void *)key {
    objc_setAssociatedObject(self, key, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)associatedObjectForKey:(const void *)key {
    return objc_getAssociatedObject(self, key);
}

@end
