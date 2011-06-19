//
//  HELabel.h
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEViewable.h"
#import "HELayoutable.h"

@interface HELabel : UILabel <HEViewable, HELayoutable>

- (void) setBackground:(NSString*)value;

@end
