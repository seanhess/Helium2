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

- (id) init {
    if ((self = [super init])) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClick:) name:@"click" object:nil];    
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"click" object:nil];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void) loadPageFromString:(NSString*)string {
    id<HEObject> page = [HEParser parseString:string];
    [self loadPage:(id<HEViewable>)page];    
}

- (void) loadPage:(id<HEViewable>)page {

    page.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    page.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:page.view];

}

- (void) onClick:(NSNotification*)note {

//    if ([note.object conformsToProtocol:@protocol(HEViewable)]) {
//        if ([[(id<HEViewable>)note.object view] isDescendantOfView:self.view]) {
//            NSString * page = [[note userInfo] objectForKey:@"url"];
//            [self loadPageFromFile:page];            
//        }
//    }
//    
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
