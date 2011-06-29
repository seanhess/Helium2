//
//  ExampleView.m
//  HeliumDemo
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "ExampleView.h"

@implementation ExampleView

- (id)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        self.frame = CGRectMake(0, 0, 100, 100);
        UILabel * label = [[UILabel new] autorelease];
        label.frame = CGRectMake(0, 0, 100, 100);
        label.text = @"This is a Custom view";
        label.backgroundColor = [UIColor clearColor];
        [self addSubview:label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
