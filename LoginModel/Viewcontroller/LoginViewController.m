//
//  ViewController.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/13.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"
#import "GIDGoogleUser+LoginSuccessModel.h"
#import "LineSDKCredential+LoginSuccessModel.h"

@interface LoginViewController()

@end


@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//GoogleSignIn delegate
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error{
    [self.delegate LoginSuccessWithModel:user];
}

- (void)signIn:(GIDSignIn *)signIn didDisconnectWithUser:(GIDGoogleUser *)user withError:(NSError *)error{
}

//LineSignIn delegate
-(void)didLogin:(LineSDKLogin *)login credential:(LineSDKCredential *)credential profile:(LineSDKProfile *)profile error:(NSError *)error{
    [self.delegate LoginSuccessWithModel:credential];
}

@end
