//
//  Bud_DealViewController.m
//  Buddah
//
//  Created by Saxon Parker on 12/2/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_DealViewController.h"
#import "Bud_ReviewTableDelegate.h"

@interface Bud_DealViewController ()
@property (nonatomic, strong) Bud_ReviewTableDelegate *reviewDelegate;
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
- (IBAction)showReviews {
    [self performSegueWithIdentifier:@"showReviews" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showReviews"]){
        ((Bud_TableViewController *)segue.destinationViewController).cellDelegate = self.reviewDelegate;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // Fill the labels
    self.priceLabel.text = [self.priceLabel.text stringByAppendingString:self.deal.price.stringValue];
    self.descriptionLabel.text = self.deal.description;
    self.ratingLabel.text = [self.ratingLabel.text stringByAppendingString:self.deal.rating.stringValue];
    self.endLabel.text = [self.endLabel.text stringByAppendingString:self.deal.duration.stringValue];
    
    self.reviewDelegate = [[Bud_ReviewTableDelegate alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
