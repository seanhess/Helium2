//
//  HEButton.h
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEViewable.h"
#import "HELayoutable.h"

@interface HEButton : NSObject <HEViewable, HELayoutable>

@property (nonatomic, retain) NSString * background;
@property (nonatomic, retain) NSString * text;

//- (void) setBackground:(NSString*)value;
//- (void) setText:(NSString*)value;

@end
