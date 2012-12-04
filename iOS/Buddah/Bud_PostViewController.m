//
//  Bud_PostViewController.m
//  Buddah
//
//  Created by Saxon Parker on 11/27/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_PostViewController.h"

@interface Bud_PostViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic) BOOL prefillWithData;
@property (nonatomic) BOOL keyBoardIsShown;
@property (nonatomic, weak) UITextField* activeField;
@end

@implementation Bud_PostViewController
@synthesize PriceText = _PriceText;
@synthesize DescriptionText = _DescriptionText;
@synthesize LocationText = _LocationText;
@synthesize StartDate = _StartDate;
@synthesize post = _post;
@synthesize scrollView = _scrollView;
@synthesize EndDate = _EndDate;
@synthesize activeField = _activeField;


- (void)prefillPost:(postData*)postData
{
    self.post = postData;
    self.prefillWithData = YES;
}

- (void)prefillText{
    [self.PriceText setText:self.post.priceText];
    self.DescriptionText.text = self.post.descriptionText;
    self.LocationText.text = self.post.locationText;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissTextView:(UITextView*)textView{
    [textView resignFirstResponder];
    [textView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self dismissTextView:self.DescriptionText];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}

- (void)scrollViewTapped:(UITapGestureRecognizer *)recognizer{
    [self dismissTextView:self.DescriptionText];
    [self.PriceText resignFirstResponder];
    [self.LocationText resignFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.activeField = nil;
}


/* resizing the view to handle the keyboard being shown */
#define kKeyboardAnimationDuration 0.3
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    self.keyBoardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    if (self.keyBoardIsShown) {
        return;
    }
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    CGPoint origin = self.activeField.frame.origin;
    origin.y -= self.scrollView.contentOffset.y;
    if (!CGRectContainsPoint(aRect, origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.activeField.frame.origin.y-(aRect.size.height - self.navigationController.navigationBar.frame.size.height));
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    self.keyBoardIsShown = YES;
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    self.keyBoardIsShown = NO;
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTapped:)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    [self.scrollView addGestureRecognizer:tapRecognizer];
    
    self.DescriptionText.layer.borderWidth = 2.0f;
    self.DescriptionText.layer.borderColor = [[UIColor grayColor] CGColor];
    self.DescriptionText.layer.cornerRadius = 8.0f;
    self.DescriptionText.clipsToBounds = YES;
    [self.DescriptionText.layer setMasksToBounds:YES];
    
    ((UIScrollView *)self.scrollView).contentSize = CGSizeMake(320, 800);
    
    if(self.prefillWithData)
        [self prefillText];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
