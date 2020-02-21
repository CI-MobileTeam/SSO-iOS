//
//  LineSDKConfiguration+CustomerLineConfig.m
//  LoginModel
//
//  Created by CI-Hank.Chien on 2020/2/21.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import "LineSDKConfiguration+CustomerLineConfig.h"
#import "LoginManager.h"


@implementation LineSDKConfiguration (CustomerLineConfig)

-(NSString *)channelID{
    return [LoginManager sharedInstance].dataSource.lineChannel;
}

@end
