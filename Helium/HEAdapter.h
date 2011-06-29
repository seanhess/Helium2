//
//  HEAdapter.h
//  Helium
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEBase.h"
#import "HEViewable.h"
#import "HEViewControllable.h"

@interface HEAdapter : HEBase <HEViewable, HEViewControllable>
@property (nonatomic, assign) Class type;
@property (nonatomic, retain) NSString * nibName;
@end
