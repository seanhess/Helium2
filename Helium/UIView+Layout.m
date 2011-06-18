
//
//  UIView+Layout.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)



- (void) calculateLayoutWithLeft:(NSNumber *)left top:(NSNumber *)top right:(NSNumber *)right bottom:(NSNumber *)bottom width:(NSNumber *)width height:(NSNumber *)height {

    [self calculateLayoutWithLeft:left top:top right:right bottom:bottom width:width height:height nativeWidth:nil nativeHeight:nil];

}


- (void)calculateLayoutWithLeft:(NSNumber*)left top:(NSNumber*)top right:(NSNumber*)right bottom:(NSNumber*)bottom width:(NSNumber*)width height:(NSNumber*)height nativeWidth:(NSNumber*)nativeWidth nativeHeight:(NSNumber*)nativeHeight {
    

    UIViewAutoresizing mask = UIViewAutoresizingNone;
    

    
    
    // -width: calculate width based on left and right
    // -height: calculate height based on top and bottom
    
    // -left: calculate based on width and right
    // -right: ignore (0)
    
    // -top: calculate based on bottom and height
    // -bottom: ignore (0)
    
    BOOL shouldStretchHeight = (top && bottom); // if top and bottom are set, must stretch
    BOOL shouldStretchWidth = (right && left);
    
    BOOL shouldPegBottom = (bottom && !top);
    BOOL shouldPegRight = (right && !left);
    
    CGFloat x, y, h, w;
    
    // WIDTH 
    if (width)
        w = width.intValue;
        
    else if (nativeWidth && !shouldStretchWidth)
        w = nativeWidth.intValue;    
    
    else {
        w = self.superview.bounds.size.width - left.intValue - right.intValue;
        mask = mask | UIViewAutoresizingFlexibleWidth;    
    }
        
        
    // HEIGHT
    if (height)
        h = height.intValue;

    else if (nativeHeight && !shouldStretchHeight)
        h = nativeHeight.intValue;        

    else {
        h = self.superview.bounds.size.height - top.intValue - bottom.intValue;
        mask = mask | UIViewAutoresizingFlexibleHeight;          
    }




    // X

    if (shouldPegRight) {
        x = self.superview.bounds.size.width - right.intValue - w;
        mask = mask | UIViewAutoresizingFlexibleLeftMargin;                         
    }
        
    else 
        x = left.intValue;
        
        
        
    // Y
        
    if (shouldPegBottom) {
        y = self.superview.bounds.size.height - bottom.intValue - h;
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
