//
//  Bud_ViewController.h
//  Buddah
//
//  Created by Saxon Parker on 11/19/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <RestKit/RestKit.h>
#import "Response_Request.h"
#import "RestfulCalls.h"
#import "Bud_TableViewController.h"
#import "Bud_NearbyTableDelegate.h"
#import "Bud_RecentTableDelegate.h"

@interface Bud_ViewController : UIViewController
@property (nonatomic, strong) Bud_NearbyTableDelegate* nearbyDelegate;
@property (nonatomic, strong) Bud_RecentTableDelegate* recentDelegate;
@end
