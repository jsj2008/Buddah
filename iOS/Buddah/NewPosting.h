//
//  NewPosting.h
//  Buddah
//
//  Created by Saxon Parker on 12/11/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Listing.h"
@interface NewPosting : NSObject
//Request
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) Listing *listing;

//Response
@property (strong, nonatomic) NSNumber *timeLeft;
@end
