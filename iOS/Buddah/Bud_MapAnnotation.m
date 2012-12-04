//
//  Bud_mapAnnotation.m
//  Buddah
//
//  Created by Saxon Parker on 12/2/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_MapAnnotation.h"

@implementation Bud_MapAnnotation
@synthesize deal = _deal;

+ (Bud_MapAnnotation *)annotationForDeal:(dealData *)deal{
    Bud_MapAnnotation *annotation = [[Bud_MapAnnotation alloc] init];
    annotation.deal = deal;
    return annotation;
}

- (NSString *)title{
    return self.deal.priceText;
}

- (NSString *)subtitle{
    return self.deal.descriptionText;
}

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = self.deal.latitude;
    coordinate.longitude = self.deal.longitude;
    return coordinate;
}

@end
