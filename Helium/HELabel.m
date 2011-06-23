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

- (void) dealloc {
    [label release];
    [text release];
    [super dealloc];
}

- (UIView*)view {
    return self.label;
}

- (void) didInitialize {
    self.label = [UILabel new];
    self.label.text = text;
    [super didInitialize];
}


@end
