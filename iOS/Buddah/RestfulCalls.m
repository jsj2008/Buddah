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
    __block int wait = -1;
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
            wait = 1;
        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
            NSLog(@"login request failed to send");
            wait = 1;
        }];
    
    while(wait ==-1){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
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
    __block int wait = -1;
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
        wait = 1;
    }failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"It failed %@", error);
        wait = 1;
    }
     ];
    while(wait ==-1){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
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
    __block int wait = -1;
    __block GetDeals *results;
    
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
  //  RKRequestDescriptor *reqDesc = [RKRequestDescriptor requestDescriptorWithMapping:dealsInverse objectClass:[GetDeals class] rootKeyPath:nil];
    
   // NSDictionary *params = [RKObjectParameterization parametersWithObject:request requestDescriptor:reqDesc error:nil];
    
    
    RKObjectMapping *dealsRespMap = [RKObjectMapping mappingForClass:[GetDeals class]];
    [dealsRespMap addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"listings" toKeyPath:@"listings" withMapping:listingMapping]];
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
            results = first;
        }
        wait = 1;
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get deals");
        results = nil;
        wait = 1;
    }];
    
  /*  NSMutableURLRequest *urlRequest = [[RKObjectManager sharedManager] multipartFormRequestWithObject:request method:RKRequestMethodGET path:nil parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithHeaders:[[RKObjectManager sharedManager] defaultHeaders] body:[[params debugDescription] dataUsingEncoding:[NSString defaultCStringEncoding]]];
    }];
    
   RKObjectRequestOperation *op =  [[RKObjectManager sharedManager] objectRequestOperationWithRequest:urlRequest success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        NSLog(@"successfully got deals");
        results = [mappingResult array];
        wait = 1;
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        NSLog(@"failed to get deals");
        results = nil;
        wait = 1;
    }];

    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:op];*/
    
    while(wait ==-1){
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01]];
    }
    return results;
}

@end
