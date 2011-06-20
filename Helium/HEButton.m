//
//  HEButton.m
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEButton.h"
#import "UIView+Layout.h"
#import "UIColor+Hex.h"


@interface HEButton ()
@property (nonatomic, retain) UIButton * button;
@end


@implementation HEButton

@synthesize left, right, top, bottom, width, height;
@synthesize text, background;
@synthesize button;

- (void) dealloc {
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];    
    
    [text release];
    [background release];
    [button release];
    
    [super dealloc];
}

- (UIView*)view {
    return self.button;
}

- (void) didInitialize {

    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    if (self.background)
        self.button.backgroundColor = [UIColor colorWithCSS:self.background];
        
    if (self.text)
        [self.button setTitle:self.text forState:UIControlStateNormal];  
        
    // You have to set the autoresizing mask to get the frame to fire when the superview's frame changes
    self.button.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.button addObserver:self forKeyPath:@"frame" options:0 context:nil];            
}




- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if (self.button.superview && keyPath == @"frame") {
        [self.button removeObserver:self forKeyPath:@"frame"];
        [self.button calculateFrameWithLayout:self];
    }
}



@end




