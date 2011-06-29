//
//  HEContainer.h
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEView.h"
#import "HEViewControllable.h"

@interface HEContainer : HEView <HEViewControllable>
@property (nonatomic, retain) NSString * title;
@end
