//
//  ConfirmRegisterResponse.h
//  Buddah
//
//  Created by Saxon Parker on 12/8/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfirmRegister : NSObject
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *activationCode;
@property (nonatomic, strong) NSString *username;
@end
