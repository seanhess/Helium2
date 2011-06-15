//
//  HEContainer.h
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEParent.h"
#import "HEViewable.h"

@interface HEContainer : UIView <HEParent, HEViewable>

@property (nonatomic, retain) NSNumber * left;
@property (nonatomic, retain) NSNumber * right;
@property (nonatomic, retain) NSNumber * top;
@property (nonatomic, retain) NSNumber * bottom;

@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;

@property (nonatomic, retain) NSString * background;

@property (nonatomic, retain) NSMutableArray * children;

@end
