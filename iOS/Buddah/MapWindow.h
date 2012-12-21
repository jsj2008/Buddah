//
//  MapWindow.h
//  Buddah
//
//  Created by Saxon Parker on 12/11/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Position.h"

@interface MapWindow : NSObject
@property (nonatomic, strong) Position *upperLeftPosition;
@property (nonatomic, strong) Position *upperRightPosition;
@property (nonatomic, strong) Position *lowerLeftPosition;
@property (nonatomic, strong) Position *lowerRightPosition;
@end
