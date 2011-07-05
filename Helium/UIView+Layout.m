
//
//  UIView+Layout.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)

- (void) calculateFrameWithLayout:(id<HELayoutable>)layout {

    [self calculateLayoutWithLeft:layout.left top:layout.top right:layout.right bottom:layout.bottom width:layout.width height:layout.height];    
}

- (void) calculateLayoutWithLeft:(NSNumber *)left top:(NSNumber *)top right:(NSNumber *)right bottom:(NSNumber *)bottom width:(NSNumber *)width height:(NSNumber *)height nativeWidth:(NSNumber *)nativeWidth nativeHeight:(NSNumber *)nativeHeight {


    // When do we use nativeWidth and nativeHeight
    // NOT if width || left & right
    // OTHERWISE yes
    
    width = (width || (left && right)) ? width : nativeWidth;
    height = (height || (top && bottom)) ? height : nativeHeight;

    [self calculateLayoutWithLeft:left top:top right:right bottom:bottom width:width height:height];
}


- (void)calculateLayoutWithLeft:(NSNumber*)left top:(NSNumber*)top right:(NSNumber*)right bottom:(NSNumber*)bottom width:(NSNumber*)width height:(NSNumber*)height {
    
    //NSAssert(self.superview, @"Missing superview when calculating size!");
    

    UIViewAutoresizing mask = UIViewAutoresizingNone;
    
    CGFloat fullWidth = self.frame.size.width;
    CGFloat fullHeight = self.frame.size.height;

    CGFloat startX = self.frame.origin.x;
    CGFloat startY = self.frame.origin.y;
    
    
    // -width: calculate width based on left and right
    // -height: calculate height based on top and bottom
    
    // -left: calculate based on width and right
    // -right: ignore (0)
    
    // -top: calculate based on bottom and height
    // -bottom: ignore (0)
    
    BOOL shouldPegBottom = (bottom && !top);
    BOOL shouldPegRight = (right && !left);
    
    CGFloat x, y, h, w;
    
    // WIDTH 
    if (width)
        w = width.intValue;

    else {
        w = fullWidth - left.intValue - right.intValue;
        mask = mask | UIViewAutoresizingFlexibleWidth;    
    }
        
        
    // HEIGHT
    if (height)
        h = height.intValue;

    else {
        h = fullHeight - top.intValue - bottom.intValue;
        mask = mask | UIViewAutoresizingFlexibleHeight;          
    }




    // X
    
    if (startX) {
        x = startX;
    }

    else if (shouldPegRight) {
        x = fullWidth - right.intValue - w;
        mask = mask | UIViewAutoresizingFlexibleLeftMargin;                         
    }
        
    else
        x = left.intValue;
        
        
        
    // Y
    
    if (startY) {
        y = startY;
    }
        
    else if (shouldPegBottom) {
        y = fullHeight - bottom.intValue - h;
        mask = mask | UIViewAutoresizingFlexibleTopMargin;                    
    }
    
    else
        y = top.intValue;
        
        
        
        
    

    CGRect calculatedFrame = CGRectMake(x, y, w, h);
    self.frame = calculatedFrame;
    self.autoresizingMask = mask;


}


// MAX WIDTH, MAX HEIGHT




@end
