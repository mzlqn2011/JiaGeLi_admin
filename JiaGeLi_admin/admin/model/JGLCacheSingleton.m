//
//  JGLCacheSingleton.m
//  JiaGeLi
//
//  Created by LTY on 2019/7/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JGLCacheSingleton.h"
#import "AdminLoginViewController.h"
@implementation JGLCacheSingleton
+ (instancetype)shareInstance
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
- (BOOL)isLogin {
    if (JGLSingle.userModel) {
        return YES;
    }
    return NO;
}

- (BOOL)isLoginAndPush {
    if (JGLSingle.userModel) {
        return YES;
    }
    [kWindow.rootViewController presentViewController:[[AdminLoginViewController alloc]init] animated:YES completion:nil];
    return NO;
}
- (void)login:(LoginModel *)userModel{
    JGLSingle.userModel = userModel;
}
- (void)logout{
     JGLSingle.userModel = nil;
}
@end
