//
//  AppDelegate.m
//  LoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <LineSDK/LineSDK.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LoginManager.h"

#define GOOGLE_SIGNIN_APPID @"919405796658-0vc2qr4qi9bookf52uf26tlsgc7h2lal.apps.googleusercontent.com"
#define LINE_CHANNEL_ID @"1653849381"

@interface AppDelegate ()<LoginManagerDataSource>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [LoginManager sharedInstance].dataSource = self;
    
    [[LoginManager sharedInstance] setConfig:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler{
       if ([[LineSDKLogin sharedInstance] handleOpenURL:userActivity.webpageURL]) {
           return YES;
       }
    return YES;
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    
    if ([[GIDSignIn sharedInstance] handleURL:url]) {
        
        return YES;
        
    }
    
    if ([[LineSDKLogin sharedInstance] handleOpenURL:url]) {
        
        return YES;
    }
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:app openURL:url sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey] annotation:options[UIApplicationOpenURLOptionsAnnotationKey]];
    if (handled) {
        return YES;
    }
    
    return YES;
}

- (nonnull NSString *)GoogleAppID {
    return GOOGLE_SIGNIN_APPID;
}

- (nonnull NSString *)lineChannel {
    return LINE_CHANNEL_ID;
}

- (nonnull NSString *)FacebookAppID {
    return @"186438775778435";
}

- (nonnull NSString *)FacebookDisplayName {
    return @"Cloud-interactive login";
}




@end
