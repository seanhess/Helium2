//
//  HEButton.m
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEButton.h"
#import "UIView+Layout.h"
#import "UIColor+Hex.h"


@interface HEButton ()
@property (nonatomic, retain) UIButton * button;
@end


@implementation HEButton

@synthesize text;
@synthesize button;

- (void) dealloc {
    [text release];
    [button release];
    
    [super dealloc];
}

- (UIView*)view {
    return self.button;
}

- (void) didInitialize {

    self.button = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    if (self.text)
        [self.button setTitle:self.text forState:UIControlStateNormal];  
    
    [super didInitialize];
}



@end

