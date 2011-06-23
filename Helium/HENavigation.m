//
//  HENavigation.m
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HENavigation.h"

@interface HENavigation ()
@property (nonatomic, retain) UINavigationController * navigationController;
@end


@implementation HENavigation
@synthesize navigationController;

- (void) dealloc {
    [navigationController release];
    [super dealloc];
}

- (void) didInitialize {

    id<HEViewControllable> root = nil;
    
    for (NSObject * object in self.children) {
        if ([object conformsToProtocol:@protocol(HEViewControllable)]) {
            root = (id<HEViewControllable>)object;
            break;
        }
    }

    UIViewController * viewController = root.viewController;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
}

- (UIViewController*) viewController {
    return self.navigationController;
}

@end
