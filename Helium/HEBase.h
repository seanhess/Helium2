//
//  HEBase.h
//  Helium
//
//  Created by Sean Hess on 6/23/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEObject.h"
#import "HEViewControllable.h"

@interface HEBase : NSObject <HEObject>

// utility methods
- (id<HEViewControllable>)first;

@end
