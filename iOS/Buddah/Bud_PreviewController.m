//
//  Bud_PreviewController.m
//  Buddah
//
//  Created by Saxon Parker on 12/16/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_PreviewController.h"
#import "RestfulCalls.h"

@interface Bud_PreviewController ()

@end

@implementation Bud_PreviewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    //fill in our text fields
    self.priceLabel.text = [self.priceLabel.text stringByAppendingString:[self.listing.price stringValue]];
    self.descriptionView.text = [self.descriptionView.text stringByAppendingString:self.listing.description];
    self.locationLabel.text = [self.locationLabel.text stringByAppendingString:self.locationString];
    //format dates
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm a MM/dd/yyyy"];
    self.startLabel.text = [self.startLabel.text stringByAppendingString:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[self.listing.startTime doubleValue]]]];
    self.endLabel.text = [self.endLabel.text stringByAppendingString:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:([self.listing.startTime doubleValue] + [self.listing.duration doubleValue])]]];
}
- (IBAction)postButton {
    NewPosting *post = [[NewPosting alloc] init];
    post.listing = self.listing;
    post.userId = [RestfulCalls getUserID];
    [RestfulCalls newPostRequest:post];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
