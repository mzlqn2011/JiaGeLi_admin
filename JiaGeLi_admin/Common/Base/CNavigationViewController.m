//
//  CNavigationViewController.m
//  FirstNumCar
//
//  Created by v_xiezhaolin on 2018/9/20.
//  Copyright © 2018年 can can. All rights reserved.
//

#import "CNavigationViewController.h"

@interface CNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置手势代理
    self.interactivePopGestureRecognizer.delegate = self;
    //设置NavigationBar
    [self setupNavigationBar];
}

//设置导航栏主题
- (void)setupNavigationBar
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    //统一设置导航栏颜色，如果单个界面需要设置，可以在viewWillAppear里面设置，在viewWillDisappear设置回统一格式。
    [appearance setBarTintColor:[UIColor whiteColor]];
    
    //导航栏title格式
    NSMutableDictionary *textAttribute = [NSMutableDictionary dictionary];
    textAttribute[NSForegroundColorAttributeName] = RGB(33, 33, 33, 1);
    textAttribute[NSFontAttributeName] = boldFont(15);
    [appearance setTitleTextAttributes:textAttribute];
}

/**
 *  能拦截所有push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) { // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
        viewController.hidesBottomBarWhenPushed = YES;
        // 设置导航栏按钮
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, navigationY, navBtnHeight, navBtnHeight)];
        [button setContentHorizontalAlignment:(UIControlContentHorizontalAlignmentLeft)];
        [button setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        [button addTarget:self action:@selector(popView) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    }
    [super pushViewController:viewController animated:animated];
}

- (void)popView
{
    [self popViewControllerAnimated:YES];
}

//手势代理
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
