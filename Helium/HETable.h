//
//  HETable.h
//  Helium
//
//  Created by Sean Hess on 7/1/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HEView.h"
#import <UIKit/UIKit.h>

@interface HETable : HEView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain) NSNumber * rowHeight;
@end
