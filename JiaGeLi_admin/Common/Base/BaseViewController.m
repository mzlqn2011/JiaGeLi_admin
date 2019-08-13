//
//  BaseViewController.m
//  JiaGeLi
//
//  Created by mac on 2019/7/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

/** 修改当前UIViewController的状态栏颜色为白色 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (UIButton *)baseLeftBtn{
    if (!_baseLeftBtn) {
        _baseLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_baseLeftBtn setFrame:CGRectMake(10, kStatusBarHeight + 6,70,32)];
        _baseLeftBtn.backgroundColor = [UIColor clearColor];
        [_baseLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _baseLeftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_baseLeftBtn setImage:[UIImage imageNamed:@"left_white"] forState:UIControlStateNormal];
         [_baseLeftBtn addTarget:self action:@selector(baseBack) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_baseLeftBtn];
    }
    return _baseLeftBtn;
}
- (UIButton *)baseRightBtn {
    if (!_baseRightBtn) {
        _baseRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_baseRightBtn setFrame:CGRectMake(kScreenWidth-60, kStatusBarHeight + 7,50, 30)];
        _baseRightBtn.backgroundColor = [UIColor clearColor];
        _baseRightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_baseRightBtn setTitleColor:kGrayFontColor forState:UIControlStateNormal];
        [_baseRightBtn addTarget:self action:@selector(baseRightClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_baseRightBtn];
    }
    return _baseRightBtn;
}
- (void)baseBack{
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)baseRightClicked:(UIButton *)btn{
    
}
@end
