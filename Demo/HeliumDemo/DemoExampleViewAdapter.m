//
//  DemoExampleViewAdapter.m
//  HeliumDemo
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "DemoExampleViewAdapter.h"
#import "ExampleView.h"

@interface DemoExampleViewAdapter ()
@property (nonatomic, retain) UIView * view;
@end

@implementation DemoExampleViewAdapter
@synthesize view;

- (void) dealloc {
    [view release];
    [super dealloc];
}

- (void) didInitialize {
    self.view = [[ExampleView new] autorelease];
    [super didInitialize];
}


@end
