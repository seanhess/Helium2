//
//  HETable.m
//  Helium
//
//  Created by Sean Hess on 7/1/11.
//  Copyright 2011 I.TV. All rights reserved.
//

#import "HETable.h"
#import "HECell.h"

@interface HETable ()
@property (nonatomic, retain) UITableView * tableView;
@end

@implementation HETable
@synthesize tableView, rowHeight;

- (void) dealloc {
    [tableView release];
    [rowHeight release];
    [super dealloc];
}

- (void) didInitialize {
    self.tableView = [[UITableView new] autorelease];

    if (self.rowHeight)
        self.tableView.rowHeight = [self.rowHeight floatValue];
        
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [super didInitialize];
}

- (UIView *)view {
    return self.tableView;
}



// TABLE VIEW DATASOURCE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.children.count;
}

- (UITableViewCell *)tableView:(UITableView *)table cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [table dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    HECell * child = [self.children objectAtIndex:indexPath.row];
	cell.textLabel.text = child.text;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// TABLE VIEW DELEGATE
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HECell * child = [self.children objectAtIndex:indexPath.row];
    if (child && child.click)
        [[NSNotificationCenter defaultCenter] postNotificationName:@"click" object:self userInfo:[NSDictionary dictionaryWithObject:child.click forKey:@"url"]];
}

// NOT SUPPORT! Use rowHeight instead
//- (CGFloat)tableView:(UITableView *)table heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [super tableView:table heightForRowAtIndexPath:indexPath];
//}


@end
