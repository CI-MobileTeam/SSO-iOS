//
//  ViewController.h
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/13.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LoginSuccessModel.h"
//Thirdparty SDK
#import <LineSDK/LineSDK.h>                 //Line login SDK
@import GoogleSignIn;                       //Google login SDK
#import <FBSDKCoreKit/FBSDKCoreKit.h>       //Facebook login SDK
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@protocol LoginViewControllerDelegate <NSObject>

-(void)LoginSuccessWithModel:(id<LoginSuccessSpec>)model;
-(void)LoginFaliWithErrorMessage:(NSString *)error;


@end


@interface LoginViewController : UIViewController<GIDSignInDelegate, LineSDKLoginDelegate>

@property(weak, nonatomic)id<LoginViewControllerDelegate> delegate;

@end

