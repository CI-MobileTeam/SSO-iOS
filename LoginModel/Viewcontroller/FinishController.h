//
//  FinishController.h
//  LoginModel
//
//  Created by CI-Hank.Chien on 2020/2/17.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginSuccessModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FinishController : UIViewController

-(void)setModelAndErrorStr:(id<LoginSuccessSpec>)model error:(NSString *)errorMsg;


@end

NS_ASSUME_NONNULL_END
