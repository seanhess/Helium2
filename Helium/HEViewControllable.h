//
//  HEViewControllable.h
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEObject.h"

@protocol HEViewControllable <HEObject>
- (UIViewController*)viewController;
@end
