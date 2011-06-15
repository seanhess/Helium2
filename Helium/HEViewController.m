//
    
//  HEViewController.m
//  Helium
//
//  Created by Sean Hess on 6/8/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEViewController.h"
#import "HEParser.h"

@implementation HEViewController

- (void) dealloc {
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) loadPageFromFile:(NSString*)file {
    NSString * path = [[NSBundle mainBundle] pathForResource:file ofType:@"hml"];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    // The background
    self.view.backgroundColor = [UIColor whiteColor];

    // I should ADD the view as a sub-view, eh?
    id<HEViewable> object = [HEParser parse:data];
    
    object.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:object.view];
    
//    if ([object isKindOfClass:[HEContainer class]]) {
//        // hmm, then I need to 
//    }
    
    return;
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
