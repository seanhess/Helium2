//
//  HEContainer.m
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEContainer.h"
#import "HEParser.h"

@implementation HEContainer
@synthesize left, right, top, bottom, width, height;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void) dealloc {
    [super dealloc];
}

@end
