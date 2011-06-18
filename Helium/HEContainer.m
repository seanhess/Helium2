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
}

- (UIView*) view {
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.click)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:self.click forKey:@"url"]];
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

- (void)setBackground:(NSString *)value {    
    self.backgroundColor = [UIColor colorWithCSS:value];
}

- (void) addChild:(id<HEObject>)child {

    if ([child conformsToProtocol:@protocol(HEViewable)]) 
        [self addSubview:[(id<HEViewable>)child view]];
        
    // Later, accept more of them!

}

@end
