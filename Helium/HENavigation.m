//
//  HENavigation.m
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HENavigation.h"

@interface HENavigation ()
@property (nonatomic, assign) id<HEViewControllable> root;
@end


@implementation HENavigation
@synthesize root;

- (void) dealloc {
    [super dealloc];
}

- (void) didInitialize {

    id<HEObject> rootObject = [self.children objectAtIndex:0];
    
    if ([rootObject conformsToProtocol:@protocol(HEViewControllable)]) {
        self.root = (id<HEViewControllable>)rootObject;
    }
}

- (UIViewController*) viewController {
    return [[[UINavigationController alloc] initWithRootViewController:root.viewController] autorelease];
}

@end
