//
//  GetDeals.h
//  Buddah
//
//  Created by Saxon Parker on 12/11/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"
#import "Listing.h"
@interface GetDeals : NSObject
//requests
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) Position *position;
@property (nonatomic, strong) NSNumber *yOffset;
@property (nonatomic, strong) NSNumber *xOffset;

//responses
@property (nonatomic, strong) NSString *guid;
@property (nonatomic, strong) NSArray *listings;

@end
