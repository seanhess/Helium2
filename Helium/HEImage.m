//
//  HEImage.m
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEImage.h"
#import "UIView+Layout.h"
#import "HELoader.h"

@interface HEImage ()
@property (nonatomic, retain) UIImageView * imageView;
@property (nonatomic, assign) BOOL imageLoaded;
@end


@implementation HEImage

@synthesize source;
@synthesize imageView, imageLoaded;

- (void) dealloc {
    [source release];
    [imageView release];
    
    [super dealloc];
}

- (void) didInitialize {

    self.imageView = [UIImageView new];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData * data = [HELoader data:self.source];
        UIImage * image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            self.imageLoaded = YES;
            [self layout]; // NOW the image has a size
        });
    });
    
    
    
    [super didInitialize];
    
}

- (UIView*)view {
    return self.imageView;
}

- (void)layout {

    if (!self.imageLoaded) return;

    NSNumber * nativeWidth = [NSNumber numberWithFloat:self.imageView.image.size.width];
    NSNumber * nativeHeight = [NSNumber numberWithFloat:self.imageView.image.size.height];
    
    [self.view calculateLayoutWithLeft:self.left top:self.top right:self.right bottom:self.bottom width:self.width height:self.height nativeWidth:nativeWidth nativeHeight:nativeHeight];    
}

@end
 