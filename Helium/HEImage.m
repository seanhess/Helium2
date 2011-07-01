//
//  HEImage.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEImage.h"
#import "UIView+Layout.h"

@interface HEImage ()
@property (nonatomic, retain) UIImageView * imageView;
@end


@implementation HEImage

@synthesize source;
@synthesize imageView;

- (void) dealloc {
    [source release];
    [imageView release];
    
    [super dealloc];
}

- (void) didInitialize {

    self.imageView = [UIImageView new];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.source]];
        UIImage * image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    });
    
    
    
    [super didInitialize];
    
}

- (UIView*)view {
    return self.imageView;
}

- (void)layout {
    NSNumber * imageWidth = [NSNumber numberWithFloat:self.imageView.image.size.width];
    NSNumber * imageHeight = [NSNumber numberWithFloat:self.imageView.image.size.height];

    [self.view calculateLayoutWithLeft:self.left top:self.top right:self.right bottom:self.bottom width:self.width height:self.height nativeWidth:imageWidth nativeHeight:imageHeight];    
}

@end
 