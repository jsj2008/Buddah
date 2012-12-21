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

+ (Bud_MapAnnotation *)annotationForDeal:(Listing *)deal{
    Bud_MapAnnotation *annotation = [[Bud_MapAnnotation alloc] init];
    annotation.deal = deal;
    return annotation;
}

- (NSString *)title{
    return self.deal.username;
}

- (NSString *)subtitle{
    return [self.deal.price stringValue];
}

- (CLLocationCoordinate2D)coordinate{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = [self.deal.position.latitude doubleValue];
    coordinate.longitude = [self.deal.position.longitude doubleValue];
    return coordinate;
}

@end
