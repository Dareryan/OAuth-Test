//
//  AppDelegate.m
//  Test
//
//  Created by Dare Ryan on 4/7/14.
//  Copyright (c) 2014 Dare Ryan. All rights reserved.
//

#import "AppDelegate.h"

#import <AFNetworking/AFNetworking.h>
#import <AFOAuth2Client/AFOAuth2Client.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //    flatironappaccount
    //    shortpath*1
    
    
    //NSURL *url = [NSURL URLWithString:@"https://core.staging.shortpath.net"];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    NSString *accessToken = [defaults objectForKey:@"shortPathToken"];
//    if (!accessToken) {
//        NSString *shortPathAuthString = [NSString stringWithFormat:@"https://core.staging.shortpath.net/oauth/authorize"];
//        NSURL *shortPathAuthURL = [NSURL URLWithString:shortPathAuthString];
//        
//        [[UIApplication sharedApplication] openURL:shortPathAuthURL];
//    } else
//    {
//        NSLog(@"%@", [defaults objectForKey:@"shortPathToken"]);
//        
//    }
//
    
    NSURL *url = [NSURL URLWithString:@"https://core.staging.shortpath.net/oauth/authorize?client_id=DGSqzOPpA52alnof48tUDpg4tMiwOT68E2JNRpkM&response_type=code&redirect_uri=flatironshortpath://oauthCallback"];
    [[UIApplication sharedApplication] openURL:url];
    
    
    
    
    
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

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    
    NSLog(@"%@",url);
//    NSString *responseURL = [url absoluteString];
//    NSLog(@"%@",responseURL);
//    
//   
//   
//    NSArray *clientCodeArray = [responseURL componentsSeparatedByString:@"="];
//    
//    
//    NSString *code = [clientCodeArray lastObject];
//    
//    NSLog(@"%@",code);
//    
//
    
    NSString *pattern = @"^flatironshortpath:\\/\\/oauthCallback\\?code=(.+)&";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSString *urlString = [url absoluteString];
    NSArray *matches = [regex matchesInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
    NSTextCheckingResult *match = matches[0];
    NSString *code = [urlString substringWithRange:[match rangeAtIndex:1]];
    
    NSLog(@"%@",code);
    
    NSURL *baseURL = [NSURL URLWithString:@"https://core.staging.shortpath.net"];
    AFOAuth2Client *oauthClient = [AFOAuth2Client clientWithBaseURL:baseURL clientID:@"DGSqzOPpA52alnof48tUDpg4tMiwOT68E2JNRpkM" secret:@"Wr8FIOSfEMnZwKr4z2GVSZAXSk1Us5ruAEBARvGX"];
    [oauthClient setSecurityPolicy:AFSSLPinningModeNone];
    oauthClient.securityPolicy.allowInvalidCertificates=YES;
    [oauthClient authenticateUsingOAuthWithURLString:@"https://core.staging.shortpath.net/oauth/token" code:code redirectURI:@"flatironshortpath://oauthCallback" success:^(AFOAuthCredential *credential) {
        NSLog(@"%@",credential);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
                                                                                    
//    NSURL *getAccessTokenURL = [NSURL URLWithString:@"https://core.staging.shortpath.net/oauth/token?client_id=%@&client_secret=%@&code=%@grant_type=authorization_code&redirect_uri=flatironshortpath://"];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:getAccessTokenURL];
//    request.HTTPMethod = @"POST";
//    
//    NSString *params = [NSString stringWithFormat:@"client_id=%@&client_secret=%@&code=%@",@"f523187ecd099eecc17d",@"784bc46e9c6d412b31d6dfab7d798d1078472603",code];
//    request.HTTPBody=[params dataUsingEncoding:NSUTF8StringEncoding];
//    
//    NSURLSession *session = [NSURLSession sharedSession];
//    
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSString *pattern = @"\\Aaccess_token=(.+)&scope";
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
//        NSArray *matches = [regex matchesInString:responseString options:0 range:NSMakeRange(0, [responseString length])];
//        NSTextCheckingResult *match = matches[0];
//        
//        NSString *access_token = [responseString substringWithRange:[match rangeAtIndex:1]];
//        
//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:access_token forKey:@"githubAccessToken"];
//        [defaults synchronize];
//        NSLog(@"%@",access_token);
//    }];
//    [task resume];
    return YES;
}

@end
