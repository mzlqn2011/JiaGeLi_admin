//
//  SVProgressHUD+YM.h
//  JiLaiBao
//
//  Created by 游民勇 on 15/11/27.
//  Copyright © 2015年 youmy. All rights reserved.

//  自定义遮罩

#import "SVProgressHUD.h"
typedef void(^FinishShowError)(void);
@interface SVProgressHUD (YM)
@property (nonatomic, copy) FinishShowError finishShowError;
+ (void)display;

+ (void)displaySuccessWithStatus:(NSString*)string;

+ (void)displayErrorWithStatus:(NSString *)string;
+ (void)displayErrorWithStatus:(NSString *)string finished:(FinishShowError)finishShowError;
+ (void)displayInfoWithStatusQuick:(NSString*)status;

+ (void)displayInfoWithStatus:(NSString*)status;

+ (void)displayInfoWithStatus:(NSString*)status time:(CGFloat)time;

+ (void)displaySuccessWithStatus:(NSString*)status time:(CGFloat)time;

+ (void)hide;

@end
