//
//  RestfulCalls.h
//  Buddah
//
//  Created by Saxon Parker on 12/14/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Response_Request.h"

@interface RestfulCalls : NSObject

+ (BOOL) loginRequest:(Login*)login;
+ (void) initiateRequest:(InitiateRegister *)initReq;
+ (BOOL) confirmRequest:(ConfirmRegister *)confirm;
+ (void) newPostRequest:(NewPosting *)newPost;
+ (GetDeals *) getDealsRequest:(GetDeals *)request;
+ (NSString *) getUserID;
@end
