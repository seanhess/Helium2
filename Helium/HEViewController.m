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

    }
    return self;
}

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

    NSString * extension = [file pathExtension];
    NSString * basename = [file stringByDeletingPathExtension];
    NSString * path = [[NSBundle mainBundle] pathForResource:basename ofType:extension];
    NSData * data = [NSData dataWithContentsOfFile:path];
    
    

    id<HEViewable> page = [HEParser parseData:data];
    
    [self loadPage:page];
    
}

- (void) loadPageFromString:(NSString*)string {
    id<HEViewable> page = [HEParser parseString:string];
    [self loadPage:page];    
}

- (void) loadPage:(id<HEViewable>)page {

    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"click" object:nil];

    for (UIView * view in self.view.subviews) {
        [view removeFromSuperview];
    }    
    
    // The background
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    page.view.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    page.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:page.view];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClick:) name:@"click" object:nil];    
    
}

- (void) onClick:(NSNotification*)note {

    NSLog(@"ON CLICK %@", [[note userInfo] objectForKey:@"url"]);
        
    if ([note.object conformsToProtocol:@protocol(HEViewable)]) {
        if ([[(id<HEViewable>)note.object view] isDescendantOfView:self.view]) {
            NSString * page = [[note userInfo] objectForKey:@"url"];
            [self loadPageFromFile:page];            
        }
    }
    
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
