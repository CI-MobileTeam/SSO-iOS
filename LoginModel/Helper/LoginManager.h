//
//  LoginManager.h
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/13.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginSuccessModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    LINELOGIN,
    GOOGLELOGIN,
    FACEBOOKLOGIN,
    APPLELOGIN
} LoginType;


@interface LoginManager : NSObject

+ (instancetype)sharedInstance;

-(void)LoginWithThirdParty:(LoginType)logintype presentVC:(UIViewController *)presentVC completion:(void(^)(BOOL,id<LoginSuccessSpec>, NSString *))completion;

@end

NS_ASSUME_NONNULL_END
