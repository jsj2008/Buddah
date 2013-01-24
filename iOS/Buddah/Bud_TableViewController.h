//
//  Bud_TableViewController.h
//  Buddah
//
//  Created by Saxon Parker on 1/22/13.
//  Copyright (c) 2013 Saxon Parker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Response_Request.h"
#import "Bud_DealViewController.h"
#import "Bud_ReviewViewController.h"

@class Bud_TableViewController;


/* this is the method used by the table view controller to get the data for the cells.
    Defining this protocol allows the view controller to display either ratings or listings */
@protocol TableViewControllerDelegate <NSObject>
-(NSArray *)tableViewControllerGetData:(Bud_TableViewController *)sender;
-(UITableViewCell *)tableViewControllerConfigureCell:(UITableViewCell *)cell atIndex:(NSUInteger)index;
@end


@interface Bud_TableViewController : UITableViewController
@property (nonatomic, strong) NSArray *cellData;
@property (nonatomic, weak) id <TableViewControllerDelegate> cellDelegate;
@end
