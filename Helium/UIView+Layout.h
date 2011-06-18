//
//  UIView+Layout.h
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

- (void)calculateLayoutWithLeft:(NSNumber*)left top:(NSNumber*)top right:(NSNumber*)right bottom:(NSNumber*)bottom width:(NSNumber*)width height:(NSNumber*)height nativeWidth:(NSNumber*)nativeWidth nativeHeight:(NSNumber*)nativeHeight; 

- (void)calculateLayoutWithLeft:(NSNumber*)left top:(NSNumber*)top right:(NSNumber*)right bottom:(NSNumber*)bottom width:(NSNumber*)width height:(NSNumber*)height; 

@end
