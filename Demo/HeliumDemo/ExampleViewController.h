//
//  ExampleViewController.h
//  HeliumDemo
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEViewable.h"

@interface ExampleViewController : UIViewController
@property (nonatomic, retain) id<HEViewable>page;
@end
