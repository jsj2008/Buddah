//
//  Rating.h
//  Buddah
//
//  Created by Saxon Parker on 12/11/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feedback.h"

@interface Rating : NSObject
//requests
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) Feedback *feedback;

//responses
@property (nonatomic, strong) NSArray *commentaryList;
@property (nonatomic) float averageRating;
@end
