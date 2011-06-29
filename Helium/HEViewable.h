//
//  HEViewable.h
//  Helium
//
//  Created by Sean Hess on 6/13/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEObject.h"
#import "HEViewControllable.h"

@protocol HEViewable <HEObject, HEViewControllable>
- (UIView*)view;
@end
