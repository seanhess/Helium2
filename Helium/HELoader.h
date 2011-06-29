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

+ (id<HEObject>) loadPageFromFile:(NSString*)file;
+ (id<HEObject>) loadPageFromURL:(NSString*)url;
+ (id<HEObject>) loadPageFromData:(NSData*)data;

+ (NSData*) dataFromFile:(NSString*)file;
+ (NSData*) dataFromURL:(NSString*)url;

@end
