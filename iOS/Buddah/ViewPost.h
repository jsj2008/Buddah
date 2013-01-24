//
//  ViewPost.h
//  Buddah
//
//  Created by Saxon Parker on 12/11/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feedback.h"

@interface ViewPost : NSObject
//request
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *username;

//response
@property (nonatomic, strong) NSArray *feedbackList;
@end
