//
//  Bud_PreviewController.h
//  Buddah
//
//  Created by Saxon Parker on 12/16/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Response_Request.h"

@interface Bud_PreviewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *startLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;

@property (nonatomic, strong) Listing *listing;
@property (nonatomic, strong) NSString *locationString;
@end
