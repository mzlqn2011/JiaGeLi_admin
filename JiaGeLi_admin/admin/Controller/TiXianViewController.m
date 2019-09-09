//
//  TiXianViewController.m
//  JiaGeLi_admin
//
//  Created by LTY on 2019/9/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "TiXianViewController.h"

@interface TiXianViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;
@property (weak, nonatomic) IBOutlet UITextField *alipayAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@end

@implementation TiXianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"提现申请";
    [self.sureButton drawBorderWithCornerRadius:10];
}
- (IBAction)sureButtonClick:(id)sender {
    if (self.amountTF.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入提现金额"];
        return;
    }
    if (self.alipayAccountTF.text .length == 0){
        [SVProgressHUD displayInfoWithStatus:@"请输入支付宝账号"];
        return;
    }
    if (self.nameTF.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入提现人姓名"];
        return;
    }
    [self questApply];
}

- (void)questApply{
    NSString *action = [NSString stringWithFormat:@"%s%@", kUserUrl, @"withdrawApply"];
    NSDictionary *paramDic = @{@"seller_id":JGLSingle.userModel.seller_id,@"auth_token":JGLSingle.userModel.auth_token,@"account":self.alipayAccountTF.text,@"amount":self.amountTF.text,@"name":self.nameTF.text};
    
    [kDataRequestManager POST2RequestWithUrl:action parameters:paramDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        [SVProgressHUD displaySuccessWithStatus:jsonDic[@"msg"]];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(NSError * _Nonnull error) {
        
    }];
}

@end
