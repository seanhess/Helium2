//
//  HEButton.m
//  Helium
//
//  Created by Sean Hess on 6/18/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEButton.h"
#import "UIView+Layout.h"
#import "UIColor+Hex.h"

@interface HEButtonSubclass : UIButton
@property (nonatomic, assign) id<HELayoutable> layout; // assign. The parent owns this relationship
@end



@interface HEButton ()
@property (nonatomic, retain) HEButtonSubclass * button;
@end


@implementation HEButton

@synthesize left, right, top, bottom, width, height;
@synthesize text, background;
@synthesize button;

- (void) dealloc {
    [left release];
    [right release];
    [top release];
    [bottom release];
    
    [width release];
    [height release];    
    
    [text release];
    [background release];
    [button release];
    
    [super dealloc];
}

- (UIView*)view {
    return self.button;
}

- (void) didInitialize {
    
    // Can't subclass button directly :(
    // This DOES NOT work.
    
//    self.button = [HEButtonSubclass buttonWithType:UIButtonTypeRoundedRect];
//    self.button.layout = self;
//    self.button.frame = CGRectMake(0, 0, 100, 100);
//
//    if (self.background)
//        self.button.backgroundColor = [UIColor colorWithCSS:self.background];
//        
//    if (self.text)
//        [self.button setTitle:self.text forState:UIControlStateNormal];  
//    
//    [self.button addObserver:self forKeyPath:@"frame" options:0 context:nil];
}



@end






// Hmm, this is a real challenge.
// You can't effectively subclass a button, because it's a "class cluster"
// see here: 


// OR, even better, I need a way to create these things without resorting to subclassing. 

// 1 // I don't think willMoveToSuperview does anything in UIView (since you don't have to call super)
// so, create a category on UIView that calls a delegate. The delegate can do this stuff
// or, even better, can we do this kind of thing directly? Yeah, make a new method to override: 
    // superviewFrameDidChange, and allow it to call some delegate's method. 
    
// How to view controllers work? they seem to be able to do almost anything with viewDidLoad
    // I could make this class a UIViewController, and set it's view to the UIButton
    
// OR, even better, 

// For example, add categories to UIView that extend it and allow specifying a delegate, which 
// can handle these methods (superview frame changes, specifically)

// What about dynamically allowing them to specify left/top/bottom/right on any view, rather than
// having to re-implement it in every single subclass? That would certainly be easier, no?



@implementation HEButtonSubclass
@synthesize layout;

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self.superview removeObserver:self forKeyPath:@"frame"];
}

- (void)didMoveToSuperview {
    [self.superview addObserver:self forKeyPath:@"frame" options:0 context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self calculateLayoutWithLeft:layout.left top:layout.top right:layout.right bottom:layout.bottom width:layout.width height:layout.height];
}

@end
