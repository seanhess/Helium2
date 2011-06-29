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

+ (void) initializeWithBaseURL:(NSString*)url;

+ (id<HEObject>) loadPage:(NSString*)fileOrUrl;
+ (id<HEObject>) loadPageFromData:(NSData*)data;

+ (NSData*) data:(NSString*)fileOrUrl;
+ (NSData*) dataFromFile:(NSString*)file;
+ (NSData*) dataFromURL:(NSString*)url;

@end
