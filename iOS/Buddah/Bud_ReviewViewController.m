//
//  Bud_ReviewViewController.m
//  Buddah
//
//  Created by Saxon Parker on 1/23/13.
//  Copyright (c) 2013 Saxon Parker. All rights reserved.
//

#import "Bud_ReviewViewController.h"

@interface Bud_ReviewViewController ()

@end

@implementation Bud_ReviewViewController

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
    self.ratingLabel.text = [self.ratingLabel.text stringByAppendingString:self.feedback.rating.stringValue];
    self.commentText.text = self.feedback.commentary;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
