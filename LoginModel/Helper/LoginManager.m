//
//  LoginManager.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/13.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "LoginManager.h"
#import "LoginViewController.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "ASAuthorizationAppleIDCredential+LoginSuccessModel.h"

typedef void(^ObserveOfSentButton)(BOOL);

@interface LoginManager()<LoginViewControllerDelegate, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>


@property(strong, nonatomic)LoginViewController *delegateVC;
@property(copy, nonatomic)void(^LoginBlock)(BOOL,id<LoginSuccessSpec>, NSString *);
@property(strong, nonatomic)UIViewController *presentVC;

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

-(void)setConfig:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    //google
    if (![self.dataSource respondsToSelector:@selector(Google_AppID)] || !self.dataSource.Google_AppID) {
        [NSException raise:@"loss Google app id" format:@"must set google app id"];
    }else{
        [[GIDSignIn sharedInstance] setClientID:self.dataSource.Google_AppID];
    }
    //fb
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    //line
    
    //apple
    
    
    //check info.plist setting
    NSString *plistPath = @"";
    NSError *error = nil;
    NSPropertyListFormat format;
    plistPath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *temp = (NSDictionary *)[NSPropertyListSerialization propertyListWithData:plistXML options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];

    if (!temp[@"FacebookDisplayName"]) {
        [NSException raise:@"loss FacebookDisplayName" format:@"Some information must be set on info.plist key:FacebookDisplayName (about facebook)"];
    }else if (!temp[@"FacebookAppID"]){
        [NSException raise:@"loss FacebookAppID" format:@"Some information must be set on info.plist key:FacebookAppID (about facebook)"];
    }else if (!temp[@"LineSDKConfig"]){
        [NSException raise:@"loss LineSDKConfig" format:@"Some information must be set on info.plist key:LineSDKConfig (about line)"];
    }else if (temp[@"LSApplicationQueriesSchemes"]){
        NSArray *array = temp[@"LSApplicationQueriesSchemes"];
        BOOL lineInfoPlistSetted = false;
        BOOL fbInfoPlistSetted = false;
        for (int i = 0 ; i < array.count; i++) {
            if ([array[i] isEqualToString: @"lineauth2"]) {
                lineInfoPlistSetted = true;
            }
            if ([array[i] isEqualToString: @"fbauth"]) {
                fbInfoPlistSetted = true;
            }
        }
        if (!lineInfoPlistSetted) {
            [NSException raise:@"loss lineInfoPlistSetted" format:@"Some information must be set on info.plist key:LSApplicationQueriesSchemes (about line)"];
        }
        
        if (!fbInfoPlistSetted) {
            [NSException raise:@"loss fbInfoPlistSetted" format:@"Some information must be set on info.plist key:LSApplicationQueriesSchemes (about facebook)"];
        }
    }
    
}

-(void)LoginWithThirdParty:(LoginType)logintype presentVC:(UIViewController *)presentVC completion:(void(^)(BOOL,id<LoginSuccessSpec>, NSString *))completion{
    self.LoginBlock = completion;
    self.presentVC = presentVC;
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
            self.LoginBlock(NO, nil, @"be canceled");
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
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *pro = [ASAuthorizationAppleIDProvider new];
        ASAuthorizationAppleIDRequest *req = pro.createRequest;
        req.requestedScopes = @[ASAuthorizationScopeFullName,ASAuthorizationScopeEmail];
        
        ASAuthorizationController *controller = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[req]];
        
        controller.delegate = self;
        controller.presentationContextProvider = self;
        
        [controller performRequests];
    } else {
        // Fallback on earlier versions
        self.LoginBlock(NO, nil, @"only support after ios 13.0");
    }
    
}

//delegateVC callback
- (void)LoginFaliWithErrorMessage:(NSString *)error {
    self.LoginBlock(NO, nil, error);
}

- (void)LoginSuccessWithModel:(id<LoginSuccessSpec>)model {
    self.LoginBlock(YES, model, nil);
}

//apple sign in delegate
-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)){
    self.LoginBlock(NO, nil, error.description);
}

-(void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDCredential *credential =  (ASAuthorizationAppleIDCredential *)authorization.credential;
    self.LoginBlock(YES, credential, nil);
}

- (nonnull ASPresentationAnchor)presentationAnchorForAuthorizationController:(nonnull ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return self.presentVC.view.window;
}

@end
