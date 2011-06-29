//
//  HELoader.h
//  Helium
//
//  Created by Sean Hess on 6/21/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEViewControllable.h"

@interface HELoader : NSObject

+ (NSData*) dataFromFile:(NSString*)file;
+ (id<HEObject>) loadPageFromFile:(NSString*)file;

@end
