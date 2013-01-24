//
//  Bud_ReviewTableDelegate.m
//  Buddah
//
//  Created by Saxon Parker on 1/23/13.
//  Copyright (c) 2013 Saxon Parker. All rights reserved.
//

#import "Bud_ReviewTableDelegate.h"

@interface Bud_ReviewTableDelegate ()
@property (nonatomic, strong) NSArray *reviews;
@end

@implementation Bud_ReviewTableDelegate
-(NSArray *)tableViewControllerGetData:(Bud_TableViewController *)sender{
    NSMutableArray *feedback = [[NSMutableArray alloc] init];
    for(int i = 0; i < 100; i++){
        Feedback *review = [[Feedback alloc] init];
        review.rating = [[NSNumber alloc] initWithInt:i];
        review.commentary = [[NSString alloc] initWithFormat:@"This nigga gets a %d", i];
        [feedback addObject:review];
    }
    self.reviews = feedback;
    return feedback;
}

-(UITableViewCell *)tableViewControllerConfigureCell:(UITableViewCell *)cell atIndex:(NSUInteger)index{
    Feedback *review = [self.reviews objectAtIndex:index];
    cell.textLabel.text = review.rating.stringValue;
    cell.detailTextLabel.text = review.commentary;
    return cell;
}
@end
