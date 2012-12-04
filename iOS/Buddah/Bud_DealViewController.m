//
//  Bud_DealViewController.m
//  Buddah
//
//  Created by Saxon Parker on 12/2/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_DealViewController.h"

@interface Bud_DealViewController ()

@end

@implementation Bud_DealViewController
@synthesize deal = _deal;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize priceLabel = _priceLabel;
@synthesize ratingLabel = _ratingLabel;
@synthesize endLabel = _endLabel;

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
    // Fill the labels
    self.priceLabel.text = [self.priceLabel.text stringByAppendingString:self.deal.priceText];
    self.descriptionLabel.text = self.deal.descriptionText;
    self.ratingLabel.text = [self.ratingLabel.text stringByAppendingString:[[[NSNumber alloc] initWithInt:self.deal.rating] description]];
    self.endLabel.text = [self.endLabel.text stringByAppendingString:[self.deal.endTime description]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
