//
//  FinishController.m
//  LoginModel
//
//  Created by CI-Hank.Chien on 2020/2/17.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "FinishController.h"

@interface FinishController ()
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLB;
@property (weak, nonatomic) IBOutlet UILabel *userIDLB;
@property (weak, nonatomic) IBOutlet UILabel *tokenLB;

@property (strong, nonatomic) id<LoginSuccessSpec> model;
@property (strong, nonatomic) NSString *errorMsg;

@end

@implementation FinishController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setViewWithData:self.model errorMsg:self.errorMsg];
}

-(void)setModelAndErrorStr:(id<LoginSuccessSpec>)model error:(NSString *)errorMsg{
    self.model = model;
    self.errorMsg = errorMsg;
}

-(void)setViewWithData:(id<LoginSuccessSpec>)model errorMsg:(NSString *)msg{
    if (!msg) {
        self.TitleLabel.text = @"Login success!";
        self.userNameLB.text = model.userName;
        self.userIDLB.text = model.userID;
        self.tokenLB.text = model.userToken;
    }else{
        self.TitleLabel.text = @"Login Fail";
        self.userNameLB.text = msg;
        self.userIDLB.hidden = YES;
        self.tokenLB.hidden = YES;
    }
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
