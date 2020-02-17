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
#import <AuthenticationServices/AuthenticationServices.h>

@interface LoginViewController()<ASAuthorizationControllerDelegate>

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
    if (!error) {
        LoginSuccessModel *model = [LoginSuccessModel new];
        model.ID = profile.userID;
        model.name = profile.displayName;
        model.token = credential.accessToken.accessToken;
        [self.delegate LoginSuccessWithModel:model];
    }else{
        [self.delegate LoginFaliWithErrorMessage:error.localizedDescription];
    }
}


@end
