//
//  HEScroll.m
//  Helium
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEScroll.h"
#import <UIKit/UIKit.h>

@interface HEScroll ()
@property (nonatomic, retain) UIScrollView * scrollView;
@end

@implementation HEScroll

@synthesize contentHeight, contentWidth, scrollView;

- (void) dealloc {
    [contentWidth release];
    [contentHeight release];
    [scrollView release];
    [super dealloc];
}

- (void) didInitialize {
    self.scrollView = [[UIScrollView new] autorelease];
    [super didInitialize];
}

- (UIView *) view { 
    return self.scrollView;
}

- (void) layout {
    [super layout];
    
    // We can set the content size to 0 and it works the same as setting it to the full size. 
    
    CGFloat width = (self.contentWidth) ? self.contentWidth.intValue : 0; 
    CGFloat height = (self.contentHeight) ? self.contentHeight.intValue : 0; 
    self.scrollView.contentSize = CGSizeMake(width, height);
}

@end
