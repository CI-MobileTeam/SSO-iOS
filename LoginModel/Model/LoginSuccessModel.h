//
//  LoginSuccessModel.h
//  SSOLoginModel
//
//  Created by CI-Hank.Chien on 2020/2/14.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LoginSuccessSpec <NSObject>

-(NSString *)userToken;
-(NSString *)userName;
-(NSString *)userID;

@end



@interface LoginSuccessModel : NSObject<LoginSuccessSpec>

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *ID;

@end

NS_ASSUME_NONNULL_END
