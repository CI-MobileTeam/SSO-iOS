//
//  GIDGoogleUser+LoginSuccessModel.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "GIDGoogleUser+LoginSuccessModel.h"



@implementation GIDGoogleUser (LoginSuccessModel)

-(NSString *)userName{
    return self.profile.name;
}

-(NSString *)userID{
    return self.authentication.clientID;
}

- (nonnull NSString *)accessToken {
    return self.authentication.accessToken;
}

@end
