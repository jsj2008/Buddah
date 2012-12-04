//
//  Bud_PostViewController.h
//  Buddah
//
//  Created by Saxon Parker on 11/27/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "postData.h"
#import <QuartzCore/QuartzCore.h>

@interface Bud_PostViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *PriceText;
@property (weak, nonatomic) IBOutlet UITextView *DescriptionText;
@property (weak, nonatomic) IBOutlet UITextField *LocationText;
@property (weak, nonatomic) IBOutlet UIDatePicker *StartDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *EndDate;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;


@property (strong, nonatomic) postData* post;
-(void) prefillPost:(postData*)postData;

- (void)scrollViewTapped:(UITapGestureRecognizer*)recognizer;
@end
