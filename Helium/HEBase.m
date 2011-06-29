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

- (void) dealloc {
    [children release];
    [super dealloc];
}

- (void) didInitialize {

}

- (id<HEViewControllable>)first {
    
    // returns the view controllable item
    
    for (id<HEObject> object in self.children) {
        if ([object conformsToProtocol:@protocol(HEViewControllable)]) {
            return (id<HEViewControllable>)object;
        }
    }
    
    return nil;
}


@end
