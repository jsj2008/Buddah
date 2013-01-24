//
//  Bud_AppDelegate.m
//  Buddah
//
//  Created by Saxon Parker on 11/19/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "Bud_AppDelegate.h"

#define BASE_URL @"http://buddah.herokuapp.com"

@implementation Bud_AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    if(![CLLocationManager locationServicesEnabled]){
        UIAlertView *servicesDisabledAlert = [[UIAlertView alloc] initWithTitle:@"Location Services Disabled" message:@"You currently have all location services for this device disabled. If you proceed, you will be asked to confirm whether location services should be reenabled." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [servicesDisabledAlert show];
    }
    
    // Override point for customization after application launch.
    // Load default defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Defaults" ofType:@"plist"]]];
    NSLog(@"aplliction did launch");
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSLog(@" is it null??? %c", [defaults boolForKey:@"isFirstLaunch"]);
    if ([defaults boolForKey:@"isFirstLaunch"] == YES)
    {
        NSLog(@"Running for the first time");
        [defaults setBool:NO forKey:@"isFirstLaunch"];
        [defaults setBool:YES forKey:@"displayPhoneNumberPrompt"];
        [defaults setBool:NO forKey:@"displayActivationPrompt"];
        [defaults synchronize];
    }
    
    
    RKLogConfigureByName("RestKit/Network*", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    
    NSURL *baseURL = [NSURL URLWithString:BASE_URL];
    RKObjectManager *objectManager = [RKObjectManager managerWithBaseURL:baseURL];
    [objectManager setRequestSerializationMIMEType:RKMIMETypeJSON];
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    

    
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
