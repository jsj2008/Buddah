//
//  Bud_NearbyTableDelegate.m
//  Buddah
//
//  Created by Saxon Parker on 1/22/13.
//  Copyright (c) 2013 Saxon Parker. All rights reserved.
//

#import "Bud_NearbyTableDelegate.h"

@interface Bud_NearbyTableDelegate ()
@property (nonatomic, strong) NSArray *listings;
@end

@implementation Bud_NearbyTableDelegate

-(NSArray *)tableViewControllerGetData:(Bud_TableViewController *)sender{
    //want to get data from server, but fill with junk now
    //create a few fake annotations for testing
    NSDate *curDate = [[NSDate alloc] init];
    Listing * deal1 = [[Listing alloc] init];
    deal1.description = @"decent dank";
    deal1.price = [[NSNumber alloc] initWithFloat:1.34];
    deal1.startTime = [[NSNumber alloc] initWithFloat:[curDate timeIntervalSince1970]];
    NSTimeInterval time1 = 2*60*60;
    deal1.duration = [[NSNumber alloc] initWithFloat:time1];
    deal1.rating = [[NSNumber alloc] initWithFloat:1.34];
    Position *pos1 = [[Position alloc] init];
    pos1.latitude = [[NSNumber alloc] initWithFloat:40.060994];
    pos1.longitude = [[NSNumber alloc] initWithFloat:-105.209798];
    deal1.position  = pos1;
    deal1.username = @"Donkey Kong";
    deal1.cellphone = @"1111111111";
    
    Listing * deal2 = [[Listing alloc] init];
    deal2.description = @"super weed. It's the best stuff ever you won't even believe.";
    deal2.price = [[NSNumber alloc] initWithFloat:10.25];
    deal2.startTime = [[NSNumber alloc] initWithFloat:[curDate timeIntervalSince1970]];
    NSTimeInterval time2 = 4*60*60;
    deal2.duration = [[NSNumber alloc] initWithFloat:time2];
    deal2.rating = [[NSNumber alloc] initWithFloat:4.34];
    Position *pos2 = [[Position alloc] init];
    pos2.latitude = [[NSNumber alloc] initWithFloat:40.980994];
    pos2.longitude = [[NSNumber alloc] initWithFloat:-104.809798];
    deal2.position  = pos2;
    deal2.username = @"Jumpman";
    deal2.cellphone = @"2222222222";
    
    Listing * deal3 = [[Listing alloc] init];
    deal3.description = @"Oregano";
    deal3.price = [[NSNumber alloc] initWithFloat:1.34];
    deal3.startTime = [[NSNumber alloc] initWithFloat:[curDate timeIntervalSince1970]];
    NSTimeInterval time3 = 6*60*60;
    deal3.duration = [[NSNumber alloc] initWithFloat:time3];
    deal3.rating = [[NSNumber alloc] initWithFloat:43.34];
    Position *pos3 = [[Position alloc] init];
    pos3.latitude = [[NSNumber alloc] initWithFloat:40.320994];
    pos3.longitude = [[NSNumber alloc] initWithFloat:-105.903798];
    deal3.position  = pos3;
    deal3.username = @"The Princess";
    deal3.cellphone = @"3333333333";
    
    
    
    NSMutableArray *annotes = [NSMutableArray array];
    [annotes addObject:deal1];
    [annotes addObject:deal2];
    [annotes addObject:deal3];
    
    self.listings = annotes;
    return annotes;
}

-(UITableViewCell *)tableViewControllerConfigureCell:(UITableViewCell *)cell atIndex:(NSUInteger)index{
    Listing *listing = [self.listings objectAtIndex:index];
    cell.textLabel.text = listing.username;
    cell.detailTextLabel.text = listing.description;
    return cell;
}
@end
