//
//  TestViewController.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "TestViewController.h"
#import "LoginManager.h"
@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)googleSignAction:(id)sender {
    [[LoginManager sharedInstance] LoginWithThirdParty:GOOGLELOGIN presentVC:self completion:^(BOOL isSuccess, id<LoginSuccessSpec> _Nonnull model, NSString * _Nonnull errorMsg) {
            NSLog(@"userName = %@, userID = %@, Token = %@",model.userName,model.userID,model.accessToken);
    }];
}
- (IBAction)lineSignAction:(id)sender {
    [[LoginManager sharedInstance] LoginWithThirdParty:LINELOGIN presentVC:self completion:^(BOOL isSuccess, id<LoginSuccessSpec> _Nonnull model, NSString * _Nonnull errorMsg) {
        NSLog(@"userName = %@, userID = %@, Token = %@",model.userName,model.userID,model.accessToken);
    }];
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
