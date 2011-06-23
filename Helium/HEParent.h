//
//  HEParent.h
//  Helium
//
//  Created by Sean Hess on 6/13/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEObject.h"

@protocol HEParent <HEObject>
@property (nonatomic, retain) NSMutableArray * children;
- (void) addChild:(id<HEObject>)child;
@end
