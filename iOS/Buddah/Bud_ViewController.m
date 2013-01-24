//
//  Bud_ViewController.m
//  Buddah
//
//  Created by Saxon Parker on 11/19/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_ViewController.h"
#import "Bud_PostViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "postData.h"

@interface Bud_ViewController () <UIAlertViewDelegate, UITextFieldDelegate>
@property (nonatomic,strong) Listing* pData;
@property (nonatomic) BOOL userHasLoggedIn;
-(void)displayNoLoginAlertView;
@end

@implementation Bud_ViewController

@synthesize pData = _pData;
@synthesize userHasLoggedIn = _userHasLoggedIn;

/**
 * Method name: pData
 * Description: Lazy instatiation for our post data
 * Parameters:  none
 *
 */
- (Listing*) pData{
    if(!_pData){
        _pData = [[Listing alloc] init];
    }
    return _pData;
}

/**
 * Method name: prepareForSegue
 * Description: <#description#>
 * Parameters:  segue to perform, sender of the segue (normally self)
 *
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"PrefillPostSegue"]){
        NSLog(@"Prefilling Post");
        [segue.destinationViewController prefillPost:self.pData];
    }
}

/**
 * Method name: viewMap
 * Description: action for view map button
 * Parameters:  sender
 *
 */
- (IBAction)viewMap:(id)sender {
    if(!self.userHasLoggedIn){
        [self displayNoLoginAlertView];
    }
    else {
        [self performSegueWithIdentifier:@"mapSegue" sender:self];
    }
}

/**
 * Method name: newPost
 * Description: action for new Post button
 * Parameters:  <#parameters#>
 *
 */
- (IBAction)newPost {
    if(!self.userHasLoggedIn){
        [self displayNoLoginAlertView];
    }
    else {
        [self performSegueWithIdentifier:@"NewPostSegue" sender:self];
    }
}

/**
 * Method name: prefill Post
 * Description: action for prefill post. This will be eliminated eventually
 * Parameters:  <#parameters#>
 *
 */
- (IBAction)prefillPost {
    self.pData.price = [[NSNumber alloc] initWithDouble:69.69];
    self.pData.description = @"Mega Cock Munch";
    Position *pos = [[Position alloc] init];
    pos.latitude = [[NSNumber alloc] initWithDouble:-40.321];
    pos.longitude = [[NSNumber alloc] initWithDouble:105.32];
    self.pData.position =  pos;
    [self performSegueWithIdentifier:@"PrefillPostSegue" sender:self];
}


/**
 * Method name: displayAlertViewWithTitle: WithMessage:
 * Description: Displays the alert to get the user's phone number
 * Parameters:  title of alert, message for alert
 *
 */
- (void)displayAlertViewWithTitle:(NSString*)title
                      WithMessage:(NSString*)message {
    UIAlertView *phoneMessage = [[UIAlertView alloc] initWithTitle:title
                                                           message:message
                                                          delegate:self
                                                 cancelButtonTitle:@"Enter"
                                                 otherButtonTitles: nil];
    
    phoneMessage.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[phoneMessage textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [phoneMessage show];
}

/**
 * Method name: displayNoLoginAlertView
 * Description: Displays an alert when a user attempts to do something without having logged in
 * Parameters:  none
 *
 */
- (void)displayNoLoginAlertView {
    UIAlertView *phoneMessage = [[UIAlertView alloc] initWithTitle:@"No Login!"
                                                           message:@"You cannot access Buddah's features until you have registered with our system."
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles: nil];
    
    [phoneMessage show];
}

/**
 * Method name: alertView: clickedButtonAtIndex:
 * Description: Responds to button being pressed in alert view
 * Parameters:  index of button that was pressed
 *
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    // get phone number from text box
    if([title isEqualToString:@"Enter"]){
        UITextField *numberField = [alertView textFieldAtIndex:0];
        NSString *phoneNumber = numberField.text;
        NSLog(@"%@", phoneNumber);
        if(phoneNumber.length != 10){
            [self displayAlertViewWithTitle:@"Invalid Phone Number"
                                WithMessage:@"Please enter a valid, ten digit phone number."];
            return;
        }
        InitiateRegister *initReq = [[InitiateRegister alloc] init];
        initReq.cellphone = phoneNumber;
        [RestfulCalls initiateRequest:initReq];
    
        // set up prompt for activation
        NSLog(@"Should see activation prompt");
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"displayActivationPrompt"];
        [defaults setValue:phoneNumber forKey:@"cellphone"];
        [defaults synchronize];
    }
    else if([title isEqualToString:@"Done"]){
        UITextField *actText = [alertView textFieldAtIndex:0];
        UITextField *userText = [alertView textFieldAtIndex:1];
        ConfirmRegister *confirm = [[ConfirmRegister alloc] init];
        confirm.activationCode = actText.text;
        confirm.username = userText.text;
        NSLog(@"act key = %@  user name = %@", confirm.activationCode, confirm.username);
        if([RestfulCalls confirmRequest:confirm]){
            NSLog(@"Logging in now");
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setValue:userText.text forKey:@"userName"];
            [defaults synchronize];
            Login *login = [[Login alloc] init];
            login.userId = [defaults stringForKey:@"loginToken"];
            self.userHasLoggedIn = [RestfulCalls loginRequest:login];
        }
    }
}

/**
 * Method name: viewDidLoad
 * Description: method that is called when the view is loaded.
 * Parameters:  <#parameters#>
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //check if we need to prompt for phone number
  /*  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"%@", defaults.description);
    if ([defaults boolForKey:@"displayPhoneNumberPrompt"] == YES)
    {
        NSLog(@"Should see alert");
        [self displayAlertViewWithTitle:@"Welcome to Buddah!"
                            WithMessage:@"Enter your phone number. Your activation key will be sent via SMS."];
        [defaults setValue:NO forKey:@"displayPhoneNumberPrompt"];
        [defaults synchronize];
    }
    else if ([defaults boolForKey:@"displayActivationPrompt"] == YES){
        //setup our activation alert
        UIAlertView *activationView = [[UIAlertView alloc] initWithTitle:@"Activation"
                                                                 message:@"Enter activation key and user name"
                                                                delegate:self
                                                       cancelButtonTitle:@"Done"
                                                       otherButtonTitles:nil];
        
        [activationView setAlertViewStyle:UIAlertViewStyleLoginAndPasswordInput];
        
        //customize text fields
        [[activationView textFieldAtIndex:1] setSecureTextEntry:NO];
        [[activationView textFieldAtIndex:0] setPlaceholder:@"Activation Key"];
        [[activationView textFieldAtIndex:1] setPlaceholder:@"Desired User Name"];
        
        [activationView show];
    }
    else if([defaults boolForKey:@"loginAtLaunch"]){
        Login *login = [[Login alloc] init];
        login.userId = [defaults valueForKey:@"loginToken"];
        self.userHasLoggedIn = [RestfulCalls loginRequest:login];
    }
    */
    
    int i = 0;
    for( UIViewController *view in self.tabBarController.viewControllers){
        UIViewController *visibleView;
        if([view isKindOfClass:[UINavigationController class]]){
            visibleView = [(UINavigationController *)view visibleViewController];
                ((UINavigationController *)view).navigationBar.tintColor = [UIColor colorWithRed:0.2 green:1.0 blue:0.2 alpha:1.0];
        }
        if([visibleView isKindOfClass:[Bud_TableViewController class]]){
            NSLog(@"setting up delegate");
            if([((UITabBarItem*)[self.tabBarController.tabBar.items objectAtIndex:i]).title isEqualToString:@"Nearby"]){
                NSLog(@"Nearby");
                self.nearbyDelegate = [[Bud_NearbyTableDelegate alloc] init];
                ((Bud_TableViewController*)visibleView).cellDelegate = self.nearbyDelegate;
            }
            if([((UITabBarItem*)[self.tabBarController.tabBar.items objectAtIndex:i]).title     isEqualToString:@"Recents"]){
                NSLog(@"Recents");
                self.recentDelegate = [[Bud_RecentTableDelegate alloc] init];
                ((Bud_TableViewController*)visibleView).cellDelegate = self.recentDelegate;
            }
        }
        i++;
    }

    self.userHasLoggedIn = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
