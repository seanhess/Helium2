//
//  HEParser.h
//  Helium
//
//  Created by Sean Hess on 6/9/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEViewable.h"

@interface HEParser : NSObject

+ (id<HEObject>) parseData:(NSData*)data;
+ (id<HEObject>) parseString:(NSString*)string;

@end
