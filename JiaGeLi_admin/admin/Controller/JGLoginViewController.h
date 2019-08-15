//
//  JGLoginViewController.h
//  JiaGeLi
//
//  Created by LTY on 2019/7/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void(^LoginSuccessBlock)(void);
@interface JGLoginViewController : BaseViewController
/** 登陆成功回调*/
@property(nonatomic,copy)LoginSuccessBlock loginSuccessBlock;
@end

NS_ASSUME_NONNULL_END
