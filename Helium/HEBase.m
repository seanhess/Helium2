//
//  HEBase.m
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEBase.h"

@implementation HEBase
@synthesize children;

- (NSMutableArray*) children {
    if (!children) self.children = [NSMutableArray array];
    return children;
}

- (void) didInitialize {
    
}

- (id<HEViewControllable>)root {
    
    // returns the view controllable item
    
    for (id<HEObject> object in self.children) {
        if ([object conformsToProtocol:@protocol(HEViewControllable)]) {
            return (id<HEViewControllable>)object;
        }
    }
    
    return nil;
}

- (void) addChild:(id<HEObject>)child {
    [self.children addObject:child];
}

- (void) dealloc {
    [children release];
    [super dealloc];
}

@end
