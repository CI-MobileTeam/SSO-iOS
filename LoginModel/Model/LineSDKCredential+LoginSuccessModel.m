//
//  LineSDKCredential+LoginSuccessModel.m
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "LineSDKCredential+LoginSuccessModel.h"


@implementation LineSDKCredential (LoginSuccessModel)

-(NSString *)userName{
    return self.IDToken.subject;
}

-(NSString *)userID{
    return self.IDToken.name;
}

-(NSString *)accessToken{
    return self.accessToken.accessToken;
}
@end
