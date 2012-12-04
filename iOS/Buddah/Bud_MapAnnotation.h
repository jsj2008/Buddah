//
//  Bud_mapAnnotation.h
//  Buddah
//
//  Created by Saxon Parker on 12/2/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "dealData.h"

@interface Bud_MapAnnotation : NSObject <MKAnnotation>

+ (Bud_MapAnnotation *)annotationForDeal:(dealData *)deal;
@property (nonatomic, strong) dealData *deal;
@end
