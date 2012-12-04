//
//  dealData.h
//  Buddah
//
//  Created by Saxon Parker on 12/2/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dealData : NSObject
@property (nonatomic, strong) NSString *priceText;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *locationText;
@property (nonatomic, strong) NSDate *endTime;
@property (nonatomic) int rating;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@end
