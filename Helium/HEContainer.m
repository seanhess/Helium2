//
//  HEContainer.m
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEContainer.h"
#import "HEParser.h"
#import "UIColor+Hex.h"
#import "UIView+Layout.h"

@interface HEContainer ()
@property (nonatomic, retain) NSMutableArray * children;
@end

@implementation HEContainer
@synthesize left, right, top, bottom, width, height;
@synthesize children, background, click;

- (id) init {
    if ((self = [super init])) {
        // has to be big enough to be non-negative when children calculate placement
        // self.frame = CGRectMake(0, 0, UIViewLayoutWidth, UIViewLayoutHeight);    
    }
    return self;
}

- (void) dealloc {
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];
    
    [click release];
    
    [children release];
    [super dealloc];
}

- (void) didInitialize {

    // this is too early. but why? just pretent
    // IE: don't use superview at all. 
    
    // You have to set the autoresizing mask to get the frame to fire when the superview's frame changes
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addObserver:self forKeyPath:@"frame" options:0 context:nil];    
}

- (UIView*) view {
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.click)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:self.click forKey:@"url"]];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if (self.superview && keyPath == @"frame") {
        [self removeObserver:self forKeyPath:@"frame"];
        [self calculateFrameWithLayout:self];
    }
}

- (void)setBackground:(NSString *)value {    
    self.backgroundColor = [UIColor colorWithCSS:value];
}

- (void) addChild:(id<HEObject>)child {

    if ([child conformsToProtocol:@protocol(HEViewable)]) {
        [self addSubview:[(id<HEViewable>)child view]];
    }

}

@end
