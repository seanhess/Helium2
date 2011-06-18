//
//  TestContainers.m
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "TestContainers.h"
#import "HEContainer.h"
#import "HEViewController.h"

@implementation TestContainers

- (void) setUp {

}

- (void) tearDown {

}

- (void) testMakeSureChildrenAreAdded {

    HEViewController * vc = [HEViewController new];
    vc.view.frame = CGRectMake(0, 0, 100, 100);


    HEContainer * parent = [HEContainer new];

    
    HEContainer * child = [HEContainer new];
    child.left = [NSNumber numberWithInt:10];
    child.top = [NSNumber numberWithInt:10];
    child.right = [NSNumber numberWithInt:10];
    child.bottom = [NSNumber numberWithInt:10];
    [parent addChild:child];
    

    // leave this down here to make sure it works out-of-order. It works by default
    // if you add the parent to the vc right away
    [vc loadPage:parent]; 
    
    
    // These will fail if superview.frame was 0,0,0,0 when the size was calculated
    STAssertEquals(parent.frame.size.width, 100.f, @"parent frame was not sized correctly");

    STAssertEquals(child.frame.origin.y, 10.f, @"frame was not laid out correctly");        
    
    STAssertEquals(child.frame.origin.x, 10.f, @"frame was not sized correctly");    
    STAssertEquals(child.frame.origin.y, 10.f, @"frame was not sized correctly");    


    STAssertEquals(child.frame.size.height, 80.f, @"frame was not sized correctly");    
    STAssertEquals(child.frame.size.width, 80.f, @"frame was not sized correctly");
}


@end
