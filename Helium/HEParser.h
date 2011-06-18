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

+ (id<HEViewable>) parseData:(NSData*)data;
+ (id<HEViewable>) parseString:(NSString*)string;

@end
