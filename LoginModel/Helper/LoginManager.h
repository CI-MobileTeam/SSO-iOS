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

@protocol LoginManagerDataSource <NSObject>

-(NSString *)lineChannel;
-(NSString *)GoogleAppID;
-(NSString *)FacebookAppID;
-(NSString *)FacebookDisplayName;
@end


@interface LoginManager : NSObject

@property(weak, nonatomic) id<LoginManagerDataSource> dataSource;

+ (instancetype)sharedInstance;


-(void)setConfig:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

-(void)LoginWithThirdParty:(LoginType)logintype presentVC:(UIViewController *)presentVC completion:(void(^)(BOOL,id<LoginSuccessSpec>, NSString *))completion;

@end

NS_ASSUME_NONNULL_END
