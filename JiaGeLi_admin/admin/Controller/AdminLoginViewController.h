//
//  AdminLoginViewController.h
//  JiaGeLi_admin
//
//  Created by LTY on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginSuccessBlock)(void);
@interface AdminLoginViewController : BaseViewController
/** 登陆成功回调*/
@property(nonatomic,copy)LoginSuccessBlock loginSuccessBlock;
@end

NS_ASSUME_NONNULL_END
