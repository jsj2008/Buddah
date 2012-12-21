//
//  Listing.h
//  Buddah
//
//  Created by Saxon Parker on 12/11/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Position.h"

@interface Listing : NSObject
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *cellphone;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *rating;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSNumber *duration;
@property (nonatomic, strong) Position *position;
@end
