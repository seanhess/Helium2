//
//  HEView.h
//  Helium
//
//  Created by Sean Hess on 6/20/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HEViewable.h"
#import "HELayoutable.h"
#import "HEBase.h"

@interface HEView : HEBase <HEViewable, HELayoutable>
@property (nonatomic, retain) NSString * background;
@property (nonatomic, retain) NSString * click;
- (void) layout;
@end
