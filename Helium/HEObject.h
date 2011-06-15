//
//  HEObject.h
//  Helium
//
//  Created by Sean Hess on 6/13/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HEObject <NSObject>
- (void) didInitialize;
- (void) setValue:(id)value forKey:(NSString*)key;
@end
