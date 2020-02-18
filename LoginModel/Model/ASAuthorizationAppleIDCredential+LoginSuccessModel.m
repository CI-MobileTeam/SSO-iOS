//
//  ASAuthorizationAppleIDCredential+LoginSuccessModel.m
//  LoginModel
//
//  Created by CI-Hank.Chien on 2020/2/17.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "ASAuthorizationAppleIDCredential+LoginSuccessModel.h"


@implementation ASAuthorizationAppleIDCredential (LoginSuccessModel)



- (nonnull NSString *)userID {
    return self.user;
}

- (nonnull NSString *)userName {
    return [self.fullName givenName];
}

- (nonnull NSString *)userToken {
    return [[NSString alloc] initWithData:self.identityToken encoding:kCFStringEncodingUTF8];
}

@end
