//
//  HEContainer.m
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEContainer.h"
#import "HEViewController.h"

@interface HEContainer ()
@property (nonatomic, retain) UIView * view;
@end

@implementation HEContainer
@synthesize view, title, icon;

- (void) dealloc {
    [view release];
    [title release];
    [icon release];
    [super dealloc];
}

- (void) didInitialize {
    self.view = [[UIView new] autorelease];
    [super didInitialize];
}

- (UIViewController*) viewController {
    
    // Generate dynamically, because we don't always need it. 
    // Don't retain the view controller, either, because it retains this page

    HEViewController * viewController = [[HEViewController new] autorelease]; 
    viewController.title = self.title;
    [viewController loadPage:self];
    
    if (self.icon)
        viewController.tabBarItem.image = [UIImage imageNamed:self.icon];
    
    return viewController;
}

@end
