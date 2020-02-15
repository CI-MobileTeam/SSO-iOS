//
//  LoginManager.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/13.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "LoginManager.h"
#import "LoginViewController.h"


typedef void(^ObserveOfSentButton)(BOOL);

@interface LoginManager()<LoginViewControllerDelegate>


@property(strong, nonatomic)LoginViewController *delegateVC;
@property(copy, nonatomic)void(^LoginBlock)(BOOL,id<LoginSuccessSpec>, NSString *);

@end

@implementation LoginManager

+ (instancetype)sharedInstance{
    
    static LoginManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
        manager.delegateVC = [LoginViewController new];
        manager.delegateVC.delegate = manager;
    });
    return manager;
}

-(void)LoginWithThirdParty:(LoginType)logintype presentVC:(UIViewController *)presentVC completion:(void(^)(BOOL,id<LoginSuccessSpec>, NSString *))completion{
    self.LoginBlock = completion;
    
    switch (logintype) {
        case GOOGLELOGIN:
            [self LoginWithGoogle:presentVC];
            break;
        case FACEBOOKLOGIN:
            [self LoginWithFB:presentVC];
            break;
        case LINELOGIN:
            [self LoginWithLine:presentVC];
            break;
        case APPLELOGIN:
            [self LoginWithApple];
            break;
        default:
            break;
    }
}

-(void)LoginWithLine:(UIViewController *)presentVC{
    [[LineSDKLogin sharedInstance] setDelegate:self.delegateVC];
    [[LineSDKLogin sharedInstance] startLoginWithPermissions:@[@"profile", @"friends", @"groups"]];
}

-(void)LoginWithFB:(UIViewController *)presentVC{
    FBSDKLoginManager *manager = [FBSDKLoginManager new];
    [manager logInWithPermissions:
     @[@"public_profile",@"email"] fromViewController:presentVC handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        if (error) {
            self.LoginBlock(NO, nil, error.description);
        } else if (result.isCancelled) {
            self.LoginBlock(NO, nil, nil);
        } else {
            LoginSuccessModel *model = [LoginSuccessModel new];
            model.token = result.token.tokenString;
            model.name = [FBSDKProfile currentProfile].name;
            model.ID = result.token.userID;
            self.LoginBlock(YES, model, nil);
        }
    }];
}



-(void)LoginWithGoogle:(UIViewController *)presentVC{
    [[GIDSignIn sharedInstance] setDelegate:self.delegateVC];
    [[GIDSignIn sharedInstance] setPresentingViewController:presentVC];
    [[GIDSignIn sharedInstance] signIn];
}

-(void)LoginWithApple{
    
}

//delegateVC callback
- (void)LoginFaliWithErrorMessage:(NSString *)error {
    self.LoginBlock(NO, nil, error);
}

- (void)LoginSuccessWithModel:(id<LoginSuccessSpec>)model {
    self.LoginBlock(YES, model, nil);
}

@end
