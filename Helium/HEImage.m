//
//  HEImage.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEImage.h"
#import "UIView+Layout.h"

@implementation HEImage

@synthesize left, right, top, bottom, width, height;
@synthesize source, click;

- (void) dealloc {
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];
    
    [source release];
    [click release];
    
    [super dealloc];
}

- (void) didInitialize {
    self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.source]]];    

    if (self.click) 
        self.userInteractionEnabled = YES;
}

- (UIView*)view {
    return self;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:self.click forKey:@"url"]];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.superview removeObserver:self forKeyPath:@"frame"];
}

- (void)didMoveToSuperview {
    [self.superview addObserver:self forKeyPath:@"frame" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {

    NSNumber * imageWidth = [NSNumber numberWithFloat:self.image.size.width];
    NSNumber * imageHeight = [NSNumber numberWithFloat:self.image.size.height];

    [self calculateLayoutWithLeft:self.left top:self.top right:self.right bottom:self.bottom width:self.width height:self.height nativeWidth:imageWidth nativeHeight:imageHeight];
    
}

@end
 