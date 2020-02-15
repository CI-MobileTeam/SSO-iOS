//
//  LoginSuccessModel.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "LoginSuccessModel.h"

@implementation LoginSuccessModel



- (nonnull NSString *)userID {
    return self.ID;
}

- (nonnull NSString *)userName {
    return self.name;
}

- (nonnull NSString *)userToken {
    return self.token;
}

@end
