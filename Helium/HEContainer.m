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
    
    [self calculateFrameWithLayout:self];    
    
}

- (UIView*) view {
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.click)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:self.click forKey:@"url"]];
}

- (void) didAddAsChild {
    //[self calculateFrameWithLayout:self];
}


// but there's no way to tell it who to send the messages to!
// how can I observe it? nextResponder? How do UIViewControllers work? 
// 

// Still can't tell when it's been added as a view. 
// Hijack first responder!



//- (void)willMoveToSuperview:(UIView *)newSuperview {
//    [self.superview removeObserver:self forKeyPath:@"frame"];
//}
//
//- (void)didMoveToSuperview {
//    [self.superview addObserver:self forKeyPath:@"frame" options:0 context:nil];
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//
//    // you can swizzle a method for a particular instance
//    // which would allow you to specify an instance for something? 
//    // hmm.... not bloody likely 
//    
//    // All I need to know is when it is added to the superview, and the frame changes. 
//    
//    // I don't REALLY even need to know that, if I can get the view set to something normal
//    // and it will let me expand it. 
//
//    [self calculateFrameWithLayout:self];
//}

- (void)setBackground:(NSString *)value {    
    self.backgroundColor = [UIColor colorWithCSS:value];
}

- (void) addChild:(id<HEObject>)child {

    if ([child conformsToProtocol:@protocol(HEViewable)]) {
        [self addSubview:[(id<HEViewable>)child view]];
        [(id<HEViewable>)child didAddAsChild];
    }
        
    // Later, accept more of them!

}

@end
