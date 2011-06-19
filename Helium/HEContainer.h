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
#import "HELayoutable.h"

@interface HEContainer : UIView <HEParent, HEViewable, HELayoutable>

@property (nonatomic, retain) NSString * background;
@property (nonatomic, retain) NSString * click;

@end
