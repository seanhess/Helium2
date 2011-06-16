//
//  HEViewable.h
//  Helium
//
//  Created by Sean Hess on 6/13/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEObject.h"

@protocol HEViewable <HEObject>
- (UIView*)view;
@end
