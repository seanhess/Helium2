//
//  HEImage.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEImage.h"
#import "UIView+Layout.h"

@implementation HEImage

@synthesize left, right, top, bottom, width, height;
@synthesize source, click;

- (id)init
{
    self = [super init];
    if (self) {
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
    
    [source release];
    [click release];
    
    [super dealloc];
}

- (void) didInitialize {
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.source]]];    

    if (self.click) 
        self.userInteractionEnabled = YES;
}

- (UIView*)view {
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // will not get called unless userInteractionEnabled is set
    // Now what? 
    
    // Where should it get intercepted? 
    
    // 1 // If there is a navigation controller (on the nearest view controller?)
    // 2 // Replace the view of the nearest view controller
    // 3 // A target view? The view that represents the file? 
    
    // The nearest view controller's navigation controller?
    
    // Global? (receivers can listen for changes, then check if the target view is in their hierarchy
        // that's not a bad idea, actually, and actually sounds faster. 
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:self.click forKey:@"url"]];
}

- (void) willMoveToSuperview:(UIView *)newSuperview {

}

- (void) didMoveToSuperview {   

    NSNumber * imageWidth = [NSNumber numberWithFloat:self.image.size.width];
    NSNumber * imageHeight = [NSNumber numberWithFloat:self.image.size.height];

    [self calculateLayoutWithLeft:self.left top:self.top right:self.right bottom:self.bottom width:self.width height:self.height nativeWidth:imageWidth nativeHeight:imageHeight];

//    UIViewAutoresizing mask = UIViewAutoresizingNone;
//    
//    CGFloat w = self.width.intValue; 
//    CGFloat h = self.height.intValue; 
//    CGFloat x = self.left.intValue;    
//    CGFloat y = self.top.intValue;
//    
//    if (!w) w = self.image.size.width;
//    if (!h) h = self.image.size.height;
//    
//    if (!self.top && self.bottom) {
//        y = self.superview.bounds.size.height - self.bottom.intValue - h;
//        mask = mask | UIViewAutoresizingFlexibleTopMargin;            
//    }    
//    
//    if (!self.left && self.right) {
//        x = self.superview.bounds.size.width - self.right.intValue - w;
//        mask = mask | UIViewAutoresizingFlexibleLeftMargin;             
//    }
//    
//    self.frame = CGRectMake(x, y, w, h);
//    self.autoresizingMask = mask;    

}

@end
 