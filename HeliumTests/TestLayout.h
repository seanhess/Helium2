//
//  TestLayout.h
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <UIKit/UIKit.h>

@interface TestLayout : SenTestCase
@property (nonatomic, retain) UIView * view;
@property (nonatomic, retain) UIView * parent;

@end
