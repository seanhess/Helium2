//
//  HEAdapter.m
//  Helium
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEAdapter.h"

@implementation HEAdapter
@synthesize type, title, nibName, icon;

- (void) dealloc {
    [title release];
    [icon release];
    [super dealloc];
}

- (UIView*)view {
            
    if ([self.type isSubclassOfClass:[UIView class]]) {
        return [[self.type new] autorelease];
    }
    
    return nil;
}

- (UIViewController*)viewController {
        
    if ([self.type isSubclassOfClass:[UIViewController class]]) {
    
        UIViewController * viewController = nil;
        
        if (self.nibName) 
            viewController = [[[self.type alloc] initWithNibName:self.nibName bundle:nil] autorelease];
            
        else 
            viewController = [[self.type new] autorelease];

        if (self.title)
            viewController.title = self.title;
            
        if (self.icon)
            viewController.tabBarItem.image = [UIImage imageNamed:self.icon];
            
        return viewController;
    }
    
    return nil;
}

@end
