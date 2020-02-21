//
//  TestViewController.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "TestViewController.h"
#import "LoginManager.h"
#import "FinishController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)FBLoginAction:(id)sender {
    [[LoginManager sharedInstance] LoginWithThirdParty:FACEBOOKLOGIN presentVC:self completion:^(BOOL isSuccess, id<LoginSuccessSpec> _Nonnull model, NSString * _Nonnull errorMsg) {
            NSLog(@"userName = %@, userID = %@, Token = %@",model.userName,model.userID,model.userToken);
        [self LoginResultAction:model error:errorMsg];
    }];}
- (IBAction)googleSignAction:(id)sender {
    [[LoginManager sharedInstance] LoginWithThirdParty:GOOGLELOGIN presentVC:self completion:^(BOOL isSuccess, id<LoginSuccessSpec> _Nonnull model, NSString * _Nonnull errorMsg) {
            NSLog(@"userName = %@, userID = %@, Token = %@",model.userName,model.userID,model.userToken);
        [self LoginResultAction:model error:errorMsg];

    }];
}
- (IBAction)lineSignAction:(id)sender {
    [[LoginManager sharedInstance] LoginWithThirdParty:LINELOGIN presentVC:self completion:^(BOOL isSuccess, id<LoginSuccessSpec> _Nonnull model, NSString * _Nonnull errorMsg) {
        NSLog(@"userName = %@, userID = %@, Token = %@",model.userName,model.userID,model.userToken);
        [self LoginResultAction:model error:errorMsg];

    }];
}
- (IBAction)appleSignAction:(id)sender {
    
    [[LoginManager sharedInstance] LoginWithThirdParty:APPLELOGIN presentVC:self completion:^(BOOL isSuccess, id<LoginSuccessSpec> _Nonnull model, NSString * _Nonnull errorMsg) {
        NSLog(@"userName = %@, userID = %@, Token = %@",model.userName,model.userID,model.userToken);
        [self LoginResultAction:model error:errorMsg];

    }];
}

-(void)LoginResultAction:(id<LoginSuccessSpec>)model error:(NSString *)errorMsg{
    FinishController *vc = [FinishController new];
    [vc setModelAndErrorStr:model error:errorMsg];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
