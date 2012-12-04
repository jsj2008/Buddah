//
//  Bud_ViewController.m
//  Buddah
//
//  Created by Saxon Parker on 11/19/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_ViewController.h"
#import "Bud_PostViewController.h"
#import "postData.h"

@interface Bud_ViewController ()
@property (nonatomic,strong) postData* pData;
@end

@implementation Bud_ViewController

@synthesize pData = _pData;

- (postData*) pData{
    if(!_pData){
        _pData = [[postData alloc] init];
    }
    return _pData;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PrefillPostSegue"]){
        NSLog(@"Prefilling Post");
        [segue.destinationViewController prefillPost:self.pData];
    }
}

- (IBAction)viewMap:(id)sender {
    [self performSegueWithIdentifier:@"mapSegue" sender:self];
}

- (IBAction)newPost {
    [self performSegueWithIdentifier:@"NewPostSegue" sender:self];
}

- (IBAction)prefillPost {
    [self.pData setDescriptionText:@"Eat a Dick"];
    [self.pData setLocationText:@"Mega Cock Munch"];
    [self.pData setPriceText:@"69.69"];
    //[self setPData:newData];
    [self performSegueWithIdentifier:@"PrefillPostSegue" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
