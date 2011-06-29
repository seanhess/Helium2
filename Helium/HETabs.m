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

- (void) dealloc {
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
    
    return tabBarController;
}

@end
