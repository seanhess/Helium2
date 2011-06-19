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

}


- (void)setBackground:(NSString *)value {    
    self.backgroundColor = [UIColor colorWithCSS:value];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.superview removeObserver:self forKeyPath:@"frame"];
}

- (void)didMoveToSuperview {
    [self.superview addObserver:self forKeyPath:@"frame" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self calculateLayoutWithLeft:self.left top:self.top right:self.right bottom:self.bottom width:self.width height:self.height];
}


@end
