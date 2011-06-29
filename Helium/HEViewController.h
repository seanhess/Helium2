//
//  HEViewController.h
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEViewable.h"

@interface HEViewController : UIViewController

@property (nonatomic, retain) id<HEViewable>page;

// Re-loads the page and displays it
- (void) loadPage:(id<HEViewable>)page;

@end
