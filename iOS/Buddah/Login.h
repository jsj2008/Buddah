//
//  LoginResponse.h
//  Buddah
//
//  Created by Saxon Parker on 12/8/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject
@property (nonatomic) BOOL result;
@property (nonatomic, strong) NSString *userId;
@end
