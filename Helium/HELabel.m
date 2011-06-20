//
//  HELabel.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HELabel.h"
#import "UIView+Layout.h"
#import "UIColor+Hex.h"

@implementation HELabel

@synthesize left, right, top, bottom, width, height;

- (void) dealloc {
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];    
    [super dealloc];
}

- (UIView*)view {
    return self;
}

- (void) didInitialize {
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addObserver:self forKeyPath:@"frame" options:0 context:nil];    
}


- (void)setBackground:(NSString *)value {    
    self.backgroundColor = [UIColor colorWithCSS:value];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    if (self.superview && keyPath == @"frame") {
        [self removeObserver:self forKeyPath:@"frame"];
        [self calculateFrameWithLayout:self];
    }    
}


@end
