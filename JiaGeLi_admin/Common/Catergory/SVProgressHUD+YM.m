//
//  SVProgressHUD+YM.m
//  JiLaiBao
//
//  Created by 游民勇 on 15/11/27.
//  Copyright © 2015年 youmy. All rights reserved.

//  自定义遮罩

#import "SVProgressHUD+YM.h"
@implementation SVProgressHUD (YM)

+ (void)display{
    [self setupDefaultStyle];
    [SVProgressHUD display];
}


+ (void)displaySuccessWithStatus:(NSString*)string{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [SVProgressHUD showSuccessWithStatus:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}

+ (void)displayErrorWithStatus:(NSString *)string{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [SVProgressHUD showErrorWithStatus:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
    
}
+ (void)displayErrorWithStatus:(NSString *)string finished:(FinishShowError)finishShowError{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [self showErrorWithStatus:string];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD hide];
        if (finishShowError) {
            finishShowError();
        }
    });
    
}
+ (void)displayInfoWithStatusQuick:(NSString*)status{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [SVProgressHUD showInfoWithStatus:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}

+ (void)displayInfoWithStatus:(NSString*)status{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [SVProgressHUD showInfoWithStatus:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
}

+ (void)displayInfoWithStatus:(NSString*)status time:(CGFloat)time{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [SVProgressHUD showInfoWithStatus:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
    
}
+ (void)displaySuccessWithStatus:(NSString*)status time:(CGFloat)time{
    [self setupDefaultStyle];
    [self setBackgroundColor];
    [SVProgressHUD showSuccessWithStatus:status];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hide];
    });
    
}
+ (void)hide{
    [SVProgressHUD dismiss];
}

+ (void)setupDefaultStyle{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    [SVProgressHUD setForegroundColor:[UIColor blackColor]];
    [SVProgressHUD setCornerRadius:5.0f];
}

+ (void)setBackgroundColor{
    [SVProgressHUD setBackgroundColor:RGB(79, 79, 79,1)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"jg_hud_success"]];
    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"jg_hud_error"]];
}
@end
