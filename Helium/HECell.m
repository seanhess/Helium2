//
//  HECell.m
//  Helium
//
//  Created by Sean Hess on 7/1/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HECell.h"

@implementation HECell
@synthesize text, click;

- (void) dealloc {
    [text release];
    [click release];
    [super dealloc];
}

@end
