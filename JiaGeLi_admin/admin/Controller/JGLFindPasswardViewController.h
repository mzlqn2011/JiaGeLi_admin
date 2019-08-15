//
//  JGLFindPasswardViewController.h
//  JiaGeLi
//
//  Created by LTY on 2019/7/24.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "BaseViewController.h"
NS_ASSUME_NONNULL_BEGIN
typedef void (^FindPasswardSuccess)(NSDictionary * dic);
@interface JGLFindPasswardViewController : UIViewController
/** 退出登录*/
@property(nonatomic,copy)FindPasswardSuccess findPasswardSuccess;
@end

NS_ASSUME_NONNULL_END
