//
//  HEContainer.m
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEContainer.h"

@interface HEContainer ()
@property (nonatomic, retain) UIView * view;
@end

@implementation HEContainer
@synthesize view;

- (void) dealloc {
    [view release];
    [super dealloc];
}

- (void) didInitialize {
    self.view = [[UIView new] autorelease];
    [super didInitialize];
}

@end
