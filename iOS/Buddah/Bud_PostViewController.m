//
//  Bud_PostViewController.m
//  Buddah
//
//  Created by Saxon Parker on 11/27/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_PostViewController.h"
#import "Bud_PreviewController.h"

@interface Bud_PostViewController () <UITextFieldDelegate, UITextViewDelegate, CLLocationManagerDelegate>
@property (nonatomic) BOOL prefillWithData;
@property (nonatomic) BOOL keyBoardIsShown;
@property (nonatomic, weak) UITextField* activeField;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *userLoc;
@property (nonatomic) BOOL userCurrentLocation;
@property (nonatomic, strong) NSString *locationString;
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

-(Listing*) post{
    if(!_post){
        _post = [[Listing alloc] init];
    }
    return _post;
}

- (void)prefillPost:(Listing*)postData
{
    self.post = postData;
    self.prefillWithData = YES;
}

- (void)prefillText{
    self.PriceText.text = [NSString stringWithFormat:@"Price: %f", self.post.price.floatValue];
    self.DescriptionText.text = self.post.description;
    self.LocationText.text = [NSString stringWithFormat:@"lat: %f lon: %f", self.post.position.latitude.floatValue, self.post.position.longitude.floatValue];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (IBAction)useCurrentLocation {
   self.LocationText.text = @"Current Location";
    self.locationString = @"Current Lcoation";
    self.userCurrentLocation = YES;
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.userLoc = [locations objectAtIndex:0];
    NSLog(@"lat %f lon %f", self.userLoc.coordinate.latitude, self.userLoc.coordinate.longitude);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ( [segue.identifier isEqualToString:@"PreviewSegue"]){
        [((Bud_PreviewController*)segue.destinationViewController) setLocationString:self.locationString];
        [((Bud_PreviewController*)segue.destinationViewController) setListing:self.post];
    }
}


- (IBAction)previewPost:(id)sender {
    self.post.price = [[NSNumber alloc] initWithDouble:[self.PriceText.text doubleValue]];
    self.post.description = self.DescriptionText.text;
    self.post.startTime = [[NSNumber alloc] initWithDouble:[self.StartDate.date timeIntervalSince1970]];
    NSLog(@"startTime = %f", self.post.startTime.doubleValue);
    NSLog(@"EndTime = %f", [self.EndDate.date timeIntervalSince1970]);
    self.post.duration = [[NSNumber alloc] initWithDouble:([self.EndDate.date timeIntervalSince1970] - self.post.startTime.doubleValue)];
    NSLog(@"duration %f", self.post.duration.doubleValue);
    Position *userPos = [[Position alloc] init];
    userPos.latitude = [[NSNumber alloc] initWithDouble:self.userLoc.coordinate.latitude];
    userPos.longitude = [[NSNumber alloc] initWithDouble:self.userLoc.coordinate.longitude];
    self.post.position = userPos;
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //self.post.cellphone = [defaults valueForKey:@"cellphone"];
    //self.post.username = [defaults valueForKey:@"userName"];
    self.post.cellphone = @"6969696969";
    self.post.username = @"fake username";
    
    if (!self.userCurrentLocation){
        self.locationString = self.LocationText.text;
    }
    
    [self performSegueWithIdentifier:@"PreviewSegue" sender:self];
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
    
    //[self.scrollView setFrame:CGRectMake(0, 0, 320, 500)];
   // [self.scrollView setContentSize:CGSizeMake(320.0, 1800.0)];
    
    NSLog(@"frame x %f frame y %f frame width %f frame height %f content x %f content y %f",
          self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.width, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
    
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
    
    
    if(self.prefillWithData)
        [self prefillText];
    
    /* setup location manager */
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];

    /*NewPosting *newPost = [[NewPosting alloc] init];
    NSString *user = [[NSString alloc] init];
    user = @"abcdefghijklmnop";
    newPost.userId = user;
    Listing *list = [[Listing alloc] init];
    NSString *username = [[NSString alloc] init];
    NSString *cell = [[NSString alloc] init];
    NSString *desc = [[NSString alloc] init];
    username = @"Saxon Parker";
    cell = @"1234567890";
    desc = @"definitely not weed";
    list.username = username;
    list.cellphone = cell;
    list.description = desc;
    list.rating = [[NSNumber alloc] initWithDouble:4.2];
    list.price = [[NSNumber alloc] initWithDouble:100.0];
    list.startTime = [[NSNumber alloc]initWithDouble:[[NSDate dateWithTimeIntervalSince1970:100000000.2] timeIntervalSince1970]];
    list.duration = [[NSNumber alloc] initWithLong:10000000];
    Position *pos = [[Position alloc] init];
    pos.latitude = [[NSNumber alloc] initWithDouble:-40.321];
    pos.longitude = [[NSNumber alloc] initWithDouble:105.32];
    list.position = pos;
    newPost.listing = list;
    
    [RestfulCalls newPostRequest:newPost];*/
}

- (void) viewWillAppear:(BOOL)animated{
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
}

- (void)viewDidAppear:(BOOL)animated{
    //[self.scrollView setFrame:CGRectMake(0, 0, 320, 500)];
    [self.scrollView setContentSize:CGSizeMake(320.0, 900.0)];
    
    NSLog(@"frame x %f frame y %f frame width %f frame height %f content x %f content y %f",
          self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, self.scrollView.frame.size.width, self.scrollView.frame.size.width, self.scrollView.contentSize.width, self.scrollView.contentSize.height);
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
