//
//  ExampleViewController.m
//  HeliumDemo
//
//  Created by Sean Hess on 6/29/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "ExampleViewController.h"
#import "HELoader.h"
#import "HEObject.h"
#import "HEViewable.h"

@implementation ExampleViewController
@synthesize page;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor grayColor];
        self.title = @"Example";
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // demonstrate that you can jump back to helium. 
    
    self.page = (id<HEViewable>)[HELoader loadPage:@"bundle://containers.hml"];
    self.page.view.frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height - 100);
    [self.view addSubview:self.page.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void) dealloc {
    [page release];
    [super dealloc];
}

@end
