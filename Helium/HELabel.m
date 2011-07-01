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

@interface HELabel ()
@property (nonatomic, retain) UILabel * label;
@end


@implementation HELabel
@synthesize label, text;
@synthesize color, size, font, align;

- (void) dealloc {
    [label release];
    [text release];
    [color release];
    [size release];
    [font release];
    [super dealloc];
}

- (UIView*)view {
    return self.label;
}

- (void) didInitialize {
    self.label = [UILabel new];
    
    NSString * fontName = (self.font) ? self.font : @"Arial";
    CGFloat fontSize = (self.size) ? [self.size floatValue] : 17;    
        
    self.label.font = [UIFont fontWithName:fontName size:fontSize];
    
    // Alignment
    if ([self.align isEqualToString:@"right"]) 
        self.label.textAlignment = UITextAlignmentRight;
        
    else if ([self.align isEqualToString:@"center"])
        self.label.textAlignment = UITextAlignmentCenter;
        
    // Check default background
    if (!self.background)
        self.label.backgroundColor = [UIColor clearColor];
            
    // Color
    if (self.color)
        self.label.textColor = [UIColor colorWithCSS:self.color];
    
    self.label.text = text;
    [super didInitialize];
}


@end
