//
//  HEActionLink.m
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEActionLink.h"

@implementation HEActionLink
@synthesize url;

- (void) dealloc {
    [url release];
    [super dealloc];
}

@end
