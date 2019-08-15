//
//  JGLCacheSingleton.h
//  JiaGeLi
//
//  Created by LTY on 2019/7/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JGLCacheSingleton : NSObject
+ (instancetype)shareInstance;
@property (nonatomic,assign) BOOL isLogin;
@property (nonatomic,assign) BOOL isLoginAndPush;
@property (nonatomic,strong) LoginModel *userModel;   // 全局用户信息对象// 是否登录(如果没登录会push登录控制器)
- (void)login:(LoginModel *)userModel;
- (void)logout;
-(void)makePhoneCall;
@end

NS_ASSUME_NONNULL_END
