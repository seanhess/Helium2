//
//  HETabs.m
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HETabs.h"

@implementation HETabs
@synthesize title, icon;

- (void) dealloc {
    [title release];
    [icon release];
    [super dealloc];
}

- (UIViewController*) viewController {
    UITabBarController * tabBarController = [[UITabBarController new] autorelease];
    NSMutableArray * viewControllers = [NSMutableArray array];
    
    for (id<HEObject> object in self.children) {
        if ([object conformsToProtocol:@protocol(HEViewControllable)]) {
            [viewControllers addObject:[(id<HEViewControllable>)object viewController]];
        }
    }
    
    tabBarController.viewControllers = viewControllers;
    
    // ignore title and icon, because nesting tab bar controllers is stupid
    
    return tabBarController;
}

@end
