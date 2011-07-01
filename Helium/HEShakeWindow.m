//
//  HEShakeWindow.m
//  Helium
//
//  Created by Sean Hess on 7/1/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEShakeWindow.h"

@implementation HEShakeWindow

- (void)dealloc {
    [super dealloc];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event 
{
    [UIApplication.sharedApplication.delegate application:UIApplication.sharedApplication didFinishLaunchingWithOptions:nil];
}

@end
