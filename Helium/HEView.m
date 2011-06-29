//
//  HEView.m
//  Helium
//
//  Created by Sean Hess on 6/20/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEView.h"
#import "UIView+Layout.h"
#import "UIColor+Hex.h"

@interface HEView ()
@end

@implementation HEView
@synthesize left, right, top, bottom, width, height;
@synthesize click;
@synthesize background;
@synthesize tap;

- (void) dealloc {
    
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];
    
    [click release];
    [background release];
    
    [self.view removeGestureRecognizer:self.tap];     
    [tap release];
    
    [super dealloc];
}

- (UIView *)view {
    return nil;
}

- (void) didInitialize {

    if (self.click) {
        self.view.userInteractionEnabled = YES;
        // Listen for clicks
        
        self.tap = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap:)] autorelease];
        [self.view addGestureRecognizer:self.tap];
    }
    
    // You have to set the autoresizing mask to get the frame to fire when the superview's frame changes
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;    
    [self.view addObserver:self forKeyPath:@"frame" options:0 context:nil]; 
    
    // Add children
    for (NSObject * child in self.children) {
        if ([child conformsToProtocol:@protocol(HEViewable)]) {
            [self.view addSubview:[(id<HEViewable>)child view]];
        }
    }
    
    // Background
    if (self.background)
        self.view.backgroundColor = [UIColor colorWithCSS:self.background];

}

- (void) onTap:(UIGestureRecognizer*)tap {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:self.click forKey:@"url"]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if (keyPath == @"frame") {
        [self.view removeObserver:self forKeyPath:@"frame"];    

        if (self.view.superview)
            [self layout];
    }
}

- (void)layout {
    [self.view calculateFrameWithLayout:self];
}





@end
