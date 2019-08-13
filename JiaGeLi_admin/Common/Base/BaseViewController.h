//
//  BaseViewController.h
//  JiaGeLi
//
//  Created by mac on 2019/7/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController
@property (nonatomic, strong) UIButton *baseLeftBtn;
@property (nonatomic, strong) UIButton *baseRightBtn;
- (void)baseBack;
/// 右边按钮
- (void)baseRightClicked:(UIButton *)btn;
@end

NS_ASSUME_NONNULL_END
