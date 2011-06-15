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

@implementation HEContainer
@synthesize left, right, top, bottom, width, height;
@synthesize children, background;

- (id) init { 
    if ((self = [super init])) {
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
    
    [children release];
    [super dealloc];
}

- (void) didInitialize {
    
    // has it initialized yet? You're not supposed to say superview, really. Hmm... how annoying. 
    
    // Default Values
    // self.frame = CGRectMake(left, top, width, height);
    
    // I think the point is that the PARENT is resposible for resizing the children, which 
    // is why you don't want it to set its own width. 
    
    // so, I need some logic to do resizing, but basically... yeah. 
    
    // Do them a little later, here? That's kind of lame, just so the superview is set
}

- (UIView*) view {
    return self;
}

- (void)didMoveToSuperview {
    
    UIViewAutoresizing mask = UIViewAutoresizingNone;
    
    CGFloat x;
    CGFloat y;
    CGFloat h;
    CGFloat w;
    
    // -width: calculate width based on left and right
    // -height: calculate height based on top and bottom
    
    // -left: calculate based on width and right
    // -right: ignore (0)
    
    // -top: calculate based on bottom and height
    // -bottom: ignore (0)
    
    if (self.height) {
        h = self.height.intValue;

        if (!self.top && self.bottom) {
            y = self.superview.bounds.size.height - self.bottom.intValue - self.height.intValue;
            mask = mask | UIViewAutoresizingFlexibleTopMargin;            
        }
        else
            y = self.top.intValue;        
    }
    
    else {
        y = self.top.intValue;
        h = self.superview.bounds.size.height - self.top.intValue - self.bottom.intValue;
        mask = mask | UIViewAutoresizingFlexibleHeight;        
    }

    if (self.width) {
        w = self.width.intValue;

        if (!self.left && self.right) {
            x = self.superview.bounds.size.width - self.right.intValue - self.width.intValue;
            mask = mask | UIViewAutoresizingFlexibleLeftMargin;             
        }
        else
            x = self.left.intValue;        
    }
    
    else {
        x = self.left.intValue;
        w = self.superview.bounds.size.width - self.left.intValue - self.right.intValue;
        mask = mask | UIViewAutoresizingFlexibleWidth;
    }


    CGRect calculatedFrame = CGRectMake(x, y, w, h);
    self.frame = calculatedFrame;
    self.autoresizingMask = mask;
    




    // Wait until our frame is set before adding children, so we don't miscalculate their frames. 
    // Maybe this isn't the best place to do this. Really, I should be observing the superview's frame?
    // Well, then I wouldn't need autoresizing masks, right? 
    
    for (id<HEObject> child in self.children) {
        if ([child conformsToProtocol:@protocol(HEViewable)]) 
            [self addSubview:[(id<HEViewable>)child view]];
    }
            
}

- (void)setBackground:(NSString *)value {    
    self.backgroundColor = [UIColor colorWithCSS:value];
}

- (void) addChild:(id<HEObject>)child {

    if (!self.children) 
        self.children = [NSMutableArray array];
        
    [self.children addObject:child];
}

@end
