//
//  HEImage.h
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEView.h"

@interface HEImage : HEView <HEViewable, HELayoutable>

@property (nonatomic, retain) NSString * source;

@end
