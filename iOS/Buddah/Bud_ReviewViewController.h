//
//  Bud_ReviewViewController.h
//  Buddah
//
//  Created by Saxon Parker on 1/23/13.
//  Copyright (c) 2013 Saxon Parker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Response_Request.h"

@interface Bud_ReviewViewController : UIViewController
@property (nonatomic, strong) Feedback *feedback;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentText;

@end
