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
@synthesize title, icon;

- (void) dealloc {
    [title release];
    [icon release];
    [super dealloc];
}

- (void) didInitialize {

}

- (UIViewController*) viewController {
    UINavigationController * controller = [[[UINavigationController alloc] initWithRootViewController:self.root.viewController] autorelease];
    
    if (self.title)
        controller.title = self.title;    
    
    if (self.icon)
        controller.tabBarItem.image = [UIImage imageNamed:self.icon];
    
    return controller;
}

@end
