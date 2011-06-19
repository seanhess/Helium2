//
//  HELayoutable.h
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEViewable.h"

@protocol HELayoutable <HEObject>

@property (nonatomic, retain) NSNumber * left;
@property (nonatomic, retain) NSNumber * right;
@property (nonatomic, retain) NSNumber * top;
@property (nonatomic, retain) NSNumber * bottom;

@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;

@end
