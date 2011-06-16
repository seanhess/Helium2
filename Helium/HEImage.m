//
//  HEImage.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEImage.h"

@implementation HEImage

@synthesize left, right, top, bottom, width, height;
@synthesize source;

- (id)init
{
    self = [super init];
    if (self) {
        NSLog(@"INIT");
    }
    
    return self;
}

- (void) dealloc {
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];
    
    [source release];
    
    [super dealloc];
}

- (void) didInitialize {
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.source]]];    
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    NSLog(@"WOOT");
    
    return;

    
}

- (UIView*)view {
    return self;
}

- (void) willMoveToSuperview:(UIView *)newSuperview {
}

- (void) didMoveToSuperview {   

    UIViewAutoresizing mask = UIViewAutoresizingNone;
    
    CGFloat w = self.width.floatValue; 
    CGFloat h = self.height.floatValue; 
    CGFloat x = self.left.floatValue;    
    CGFloat y = self.top.floatValue;
    
    if (!w) w = self.image.size.width;
    if (!h) h = self.image.size.height;
    
    if (!self.top && self.bottom) {
        y = self.superview.bounds.size.height - self.bottom.intValue - h;
        mask = mask | UIViewAutoresizingFlexibleTopMargin;            
    }    
    
    if (!self.left && self.right) {
        x = self.superview.bounds.size.width - self.right.intValue - w;
        mask = mask | UIViewAutoresizingFlexibleLeftMargin;             
    }
    
    
    self.frame = CGRectMake(x, y, w, h);
    self.autoresizingMask = mask;    

}

@end
 