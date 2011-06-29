//
//  HENavigation.m
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HENavigation.h"

@interface HENavigation ()
@end


@implementation HENavigation

- (void) dealloc {
    [super dealloc];
}

- (void) didInitialize {

}

- (UIViewController*) viewController {
    return [[[UINavigationController alloc] initWithRootViewController:self.root.viewController] autorelease];
}

@end
