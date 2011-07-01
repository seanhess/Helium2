//
//  HELabel.h
//  Helium
//
//  Created by Sean Hess on 6/15/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEView.h"

@interface HELabel : HEView
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * color;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * font;
@property (nonatomic, retain) NSString * align;
@end
