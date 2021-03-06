//
//  RestfulCalls.m
//  Buddah
//
//  Created by Saxon Parker on 12/14/12.
//  Copyright (c) 2012 Saxon Parker. All rights reserved.
//

#import "RestfulCalls.h"
#import "Restkit/Restkit.h"

@implementation RestfulCalls
BOOL loginResult = NO;
BOOL confirmResult = NO;


+ (NSString*)getUserID{
    //NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //NSString *userId = [[NSString alloc] initWithString:[defaults valueForKey:@"loginToken"]];
    //NSLog(@"%@", userId);
    //return userId;
    return @"fake user id";
}

/**
 * Method name: <#name#>
 * Description: <#description#>
 * Parameters:  <#parameters#>
 *
 */
+ (BOOL) loginRequest:(Login*)login{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    //send our login token to the server
    //setup request mapping
    RKObjectMapping *loginMapping = [RKObjectMapping requestMapping];
    [loginMapping addAttributeMappingsFromDictionary:@{@"userId" : @"userId"}];
    [[RKObjectManager sharedManager] addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:loginMapping objectClass:[Login class] rootKeyPath:nil]];
    //setup response mapping
    RKObjectMapping *loginResMap = [RKObjectMapping mappingForClass:[Login class]];
    [loginResMap addAttributeMappingsFromDictionary:@{@"result" : @"result"}];
    RKResponseDescriptor *loginRespDesc = [RKResponseDescriptor responseDescriptorWithMapping:loginResMap pathPattern:nil keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [[RKObjectManager sharedManager] addResponseDescriptor:loginRespDesc];
    //setup routing
    RKRouter *router = [[RKObjectManager sharedManager] router];
    RKRoute *loginRoute = [RKRoute routeWithClass:[Login class] pathPattern:@"/services/login" method:RKRequestMethodPOST];
    [router.routeSet addRoute:loginRoute];
    //make the put request
    
    [[RKObjectManager sharedManager] postObject:login path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"login request sent succesfully");
        id first = [mappingResult firstObject];
        if([first isMemberOfClass:[Login class]]){
            if(((Login*)first).result){
                NSLog(@"login request returned success");
                loginResult = YES;
            }
            else{
                NSLog(@"login request returned failure");
            }
        }
        dispatch_semaphore_signal(sema);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"login request failed to send");
        dispatch_semaphore_signal(sema);
    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    return loginResult;
}

/**
 * Method name: <#name#>
 * Description: <#description#>
 * Parameters:  <#parameters#>
 *
 */
+ (void) initiateRequest:(InitiateRegister *)initReq{
    // Add request mapping
    RKObjectMapping *initiateMapping = [RKObjectMapping requestMapping];
    [initiateMapping addAttributeMappingsFromDictionary:@{@"cellphone" : @"cellphone"}];
    [[RKObjectManager sharedManager] addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:initiateMapping
                                                                                                objectClass:[InitiateRegister class]
                                                                                                rootKeyPath:nil]];
    
    // Add response mapping
    RKObjectMapping *initResponseMapping = [RKObjectMapping mappingForClass:[InitiateRegister class]];
    [initResponseMapping addAttributeMappingsFromArray:@[ @"instructionMessage" ]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:initResponseMapping
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    // Set up routing
    RKRouter *router = [[RKObjectManager sharedManager] router];
    RKRoute *initiateRoute = [RKRoute routeWithClass:[InitiateRegister class] pathPattern:@"/services/initiateRegister" method:RKRequestMethodPUT];
    [router.routeSet addRoute:initiateRoute];
    
    // make the put request
    
    [[RKObjectManager sharedManager] putObject:initReq path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSLog(@"It worked %@", [[mappingResult array] description]);
        id first = [mappingResult firstObject];
        if([first isMemberOfClass:[InitiateRegister class]]){
            NSLog(@"%@", ((InitiateRegister*)first).instructionMessage);
        }
    }failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"It failed %@", error);
    }
     ];
    
}

/**
 * Method name: <#name#>
 * Description: <#description#>
 * Parameters:  <#parameters#>
 *
 */
+ (BOOL) confirmRequest:(ConfirmRegister *)confirm{
    // Send the ConfirmRegister message
    // Add request mapping
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    RKObjectMapping *confirmMapping = [RKObjectMapping requestMapping];
    [confirmMapping addAttributeMappingsFromDictionary:@{@"activationCode" : @"activationCode",
     @"username" : @"username"}];
    [[RKObjectManager sharedManager] addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:confirmMapping
                                                                                                objectClass:[ConfirmRegister class]
                                                                                                rootKeyPath:nil]];
    
    // Add response mapping
    RKObjectMapping *confirmRespMap = [RKObjectMapping mappingForClass:[ConfirmRegister class]];
    [confirmRespMap addAttributeMappingsFromArray:@[ @"token" ]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:confirmRespMap
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    // Set up routing
    RKRouter *router = [[RKObjectManager sharedManager] router];
    RKRoute *confirmRoute = [RKRoute routeWithClass:[ConfirmRegister class] pathPattern:@"/services/confirmRegister" method:RKRequestMethodPOST];
    [router.routeSet addRoute:confirmRoute];
    
    // make the put request
    [[RKObjectManager sharedManager] postObject:confirm path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSLog(@"It worked %@", [[mappingResult array] description]);
        id first = [mappingResult firstObject];
        if([first isMemberOfClass:[ConfirmRegister class]]){
            NSLog(@"%@", ((ConfirmRegister*)first).token);
        }
        confirmResult = YES;
        //Store our token for login
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:((ConfirmRegister *)first).token forKey:@"loginToken"];
        [defaults setBool:YES forKey:@"loginAtLaunch"];
        [defaults setBool:NO forKey:@"displayActivationPrompt"];
        [defaults synchronize];
        NSLog(@"oh god this dick is huge");
        dispatch_semaphore_signal(sema);
    }failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"It failed %@", error);
        dispatch_semaphore_signal(sema);
    }
     ];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    NSLog(@"Outside of post");
    return confirmResult;
}

/**
 * Method name: <#name#>
 * Description: <#description#>
 * Parameters:  <#parameters#>
 *
 */
+ (void) newPostRequest:(NewPosting *)newPost{
    RKObjectMapping *posMapping = [RKObjectMapping mappingForClass:[Position class]];
    [posMapping addAttributeMappingsFromDictionary:@{@"longitude" : @"longitude", @"latitude" : @"latitude"}];
    
    RKObjectMapping *listingMapping = [RKObjectMapping mappingForClass:[Listing class]];
    [listingMapping addAttributeMappingsFromDictionary:@{@"username" : @"username",
     @"cellphone" : @"cellphone",
     @"description" : @"description",
     @"rating" : @"rating",
     @"price" : @"price",
     @"startTime" : @"startTime",
     @"duration" : @"duration"}];
    
    [listingMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"position" toKeyPath:@"position" withMapping:posMapping]];
    
    RKObjectMapping *postMapping = [RKObjectMapping mappingForClass:[NewPosting class]];
    [postMapping addAttributeMappingsFromDictionary:@{@"userId" : @"userId"}];
    
    [postMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"listing" toKeyPath:@"listing" withMapping:listingMapping]];
    RKObjectMapping *postInverse = [postMapping inverseMapping];
    [[RKObjectManager sharedManager] addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:postInverse objectClass:[NewPosting class] rootKeyPath:nil]];
    
    
    // Add response mapping
    RKObjectMapping *postRespMap = [RKObjectMapping mappingForClass:[NewPosting class]];
    [postRespMap addAttributeMappingsFromArray:@[ @"timeLeft" ]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:postRespMap
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];
    
    // Set up routing
    RKRouter *router = [[RKObjectManager sharedManager] router];
    RKRoute *postRoute = [RKRoute routeWithClass:[NewPosting class] pathPattern:@"/services/posting" method:RKRequestMethodPUT];
    [router.routeSet addRoute:postRoute];
    
    // make the put request
    [[RKObjectManager sharedManager] putObject:newPost path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        NSLog(@"It worked %@", [[mappingResult array] description]);
        id first = [mappingResult firstObject];
        // if([first isMemberOfClass:[NewPosting class]]){
        NSLog(@"%lu", ((NewPosting*)first).timeLeft.longValue);
        //}
    }failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"It failed %@", error);
    }
     ];
}

+ (GetDeals *) getDealsRequest:(GetDeals *)request{
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    __block GetDeals *guidResults, *results;
    
    RKObjectMapping *posMapping = [RKObjectMapping mappingForClass:[Position class]];
    [posMapping addAttributeMappingsFromDictionary:@{@"longitude" : @"longitude", @"latitude" : @"latitude"}];
    
    RKObjectMapping *listingMapping = [RKObjectMapping mappingForClass:[Listing class]];
    [listingMapping addAttributeMappingsFromDictionary:@{@"username" : @"username",
     @"cellphone" : @"cellphone",
     @"description" : @"description",
     @"rating" : @"rating",
     @"price" : @"price",
     @"startTime" : @"startTime",
     @"duration" : @"duration"}];
    
    [listingMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"position" toKeyPath:@"position" withMapping:posMapping]];
    
    RKObjectMapping *dealsMapping = [RKObjectMapping mappingForClass:[GetDeals class]];
    [dealsMapping addAttributeMappingsFromDictionary:@{@"userId" : @"userId", @"xOffset" : @"xOffset", @"yOffset" : @"yOffset"}];
    [dealsMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"position" toKeyPath:@"position" withMapping:posMapping]];
    
    
    RKObjectMapping *dealsInverse = [dealsMapping inverseMapping];
    [[RKObjectManager sharedManager] addRequestDescriptor:[RKRequestDescriptor requestDescriptorWithMapping:dealsInverse objectClass:[GetDeals class] rootKeyPath:nil]];
    
    
    RKObjectMapping *dealsRespMap = [RKObjectMapping mappingForClass:[GetDeals class]];
    [dealsRespMap addAttributeMappingsFromArray:@[@"guid"]];
    RKResponseDescriptor *response = [RKResponseDescriptor responseDescriptorWithMapping:dealsRespMap pathPattern:nil keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [[RKObjectManager sharedManager] addResponseDescriptor:response];
    
    RKRouter *router = [[RKObjectManager sharedManager] router];
    RKRoute *postRoute = [RKRoute routeWithClass:[GetDeals class] pathPattern:@"/services/getDeals" method:RKRequestMethodPOST];
    [router.routeSet addRoute:postRoute];
    
    
    [[RKObjectManager sharedManager] postObject:request path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"successfully got deals");
        id first = [mappingResult firstObject];
        if([first isMemberOfClass:[GetDeals class]]){
            NSLog(@"we have a GetDeals");
            guidResults = first;
        }
        dispatch_semaphore_signal(sema);
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get deals");
        results = nil;
        dispatch_semaphore_signal(sema);
    }];
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    if (results){
        NSLog(@"guid = %@", guidResults.guid);
        dispatch_semaphore_t guidSema = dispatch_semaphore_create(0);
        RKObjectMapping *guidMapping = [RKObjectMapping requestMapping];
        [guidMapping addAttributeMappingsFromDictionary:@{@"guid" : @"guid"}];
        [[RKObjectManager sharedManager] addRequestDescriptor:
         [RKRequestDescriptor requestDescriptorWithMapping:guidMapping
                                               objectClass:[GetDeals class]
                                               rootKeyPath:nil]];
        
        //add response mapping
        RKObjectMapping *dealsRespMap = [RKObjectMapping mappingForClass:[GetDeals class]];
        [dealsRespMap addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"listings" toKeyPath:@"listings" withMapping:listingMapping]];
        RKResponseDescriptor *response = [RKResponseDescriptor responseDescriptorWithMapping:dealsRespMap pathPattern:nil keyPath:nil statusCodes:[NSIndexSet indexSetWithIndex:200]];
        [[RKObjectManager sharedManager] addResponseDescriptor:response];
        
        RKRouter *guidRouter = [[RKObjectManager sharedManager] router];
        RKRoute *postRoute = [RKRoute routeWithClass:[GetDeals class] pathPattern:@"/services/getDealsResult" method:RKRequestMethodPOST];
        [guidRouter.routeSet addRoute:postRoute];
        
        __block int reqCount = 0;
        __block BOOL success = FALSE;
        while (!success && reqCount < 20){
            [[RKObjectManager sharedManager] postObject:guidResults path:nil parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                NSLog(@"successfully got deals");
                id first = [mappingResult firstObject];
                if([first isMemberOfClass:[GetDeals class]]){
                    NSLog(@"we have a GetDeals");
                    results = first;
                    /****
                     * will need to calculate success
                     */
                    success = TRUE;
                    NSLog(@"reqCount = %d", reqCount);
                }
                dispatch_semaphore_signal(guidSema);
            } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                NSLog(@"failed to get deals");
                results = nil;
                dispatch_semaphore_signal(guidSema);
            }];
            dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        }
        reqCount++;
    }
    return results;
}

@end
