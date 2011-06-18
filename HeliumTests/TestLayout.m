//
//  TestLayout.m
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "TestLayout.h"
#import "UIView+Layout.h"

@implementation TestLayout
@synthesize view, parent;

- (void) setUp {
    self.parent = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.view = [UIView new];
    [self.parent addSubview:self.view];
}

- (void) tearDown {
    self.view = nil;
    self.parent = nil;
}

- (void) testAllFour {
    NSNumber * ten = [NSNumber numberWithInt:10];
            
    [self.view calculateLayoutWithLeft:ten top:ten right:ten bottom:ten width:nil height:nil];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 10.f, @"bad layout");
    STAssertEquals(origin.y, 10.f, @"bad layout");
    STAssertEquals(size.width, 80.f, @"bad layout");
    STAssertEquals(size.height, 80.f, @"bad layout");            
}

- (void) testFixedWidthAndHeight {
    NSNumber * ten = [NSNumber numberWithInt:10];
            
    [self.view calculateLayoutWithLeft:ten top:ten right:nil bottom:nil width:ten height:ten];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 10.f, @"bad layout");
    STAssertEquals(origin.y, 10.f, @"bad layout");
    STAssertEquals(size.width, 10.f, @"bad layout");
    STAssertEquals(size.height, 10.f, @"bad layout");   
}

- (void) testPegged {
    NSNumber * ten = [NSNumber numberWithInt:10];
            
    [self.view calculateLayoutWithLeft:nil top:nil right:ten bottom:ten width:ten height:ten];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 80.f, @"bad layout");
    STAssertEquals(origin.y, 80.f, @"bad layout");
    STAssertEquals(size.width, 10.f, @"bad layout");
    STAssertEquals(size.height, 10.f, @"bad layout");   
}

- (void) testNative {
    NSNumber * ten = [NSNumber numberWithInt:10];
            
    [self.view calculateLayoutWithLeft:ten top:ten right:nil bottom:nil width:nil height:nil nativeWidth:ten nativeHeight:ten];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 10.f, @"bad layout");
    STAssertEquals(origin.y, 10.f, @"bad layout");
    STAssertEquals(size.width, 10.f, @"bad layout");
    STAssertEquals(size.height, 10.f, @"bad layout");   
}

- (void) testSpecifiedSizeOverridesNative {
    NSNumber * ten = [NSNumber numberWithInt:10];
    NSNumber * twenty = [NSNumber numberWithInt:20];    
            
    [self.view calculateLayoutWithLeft:ten top:ten right:nil bottom:nil width:ten height:ten nativeWidth:twenty nativeHeight:twenty];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 10.f, @"bad layout");
    STAssertEquals(origin.y, 10.f, @"bad layout");
    STAssertEquals(size.width, 10.f, @"bad layout");
    STAssertEquals(size.height, 10.f, @"bad layout");   
}

- (void) testSpecifiedSizeOverridesStretch {
    NSNumber * ten = [NSNumber numberWithInt:10];
    NSNumber * twenty = [NSNumber numberWithInt:20];    
            
    [self.view calculateLayoutWithLeft:ten top:ten right:ten bottom:ten width:ten height:ten nativeWidth:twenty nativeHeight:twenty];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 10.f, @"bad layout");
    STAssertEquals(origin.y, 10.f, @"bad layout");
    STAssertEquals(size.width, 10.f, @"bad layout");
    STAssertEquals(size.height, 10.f, @"bad layout");   
}

- (void) testStrechOverridesNative {
    NSNumber * ten = [NSNumber numberWithInt:10];
    NSNumber * twenty = [NSNumber numberWithInt:20];    
            
    [self.view calculateLayoutWithLeft:ten top:ten right:ten bottom:ten width:nil height:nil nativeWidth:twenty nativeHeight:twenty];
    
    CGPoint origin = self.view.frame.origin;
    CGSize size = self.view.frame.size;
    
    STAssertEquals(origin.x, 10.f, @"bad layout");
    STAssertEquals(origin.y, 10.f, @"bad layout");
    STAssertEquals(size.width, 80.f, @"bad layout");
    STAssertEquals(size.height, 80.f, @"bad layout");   
}


@end
