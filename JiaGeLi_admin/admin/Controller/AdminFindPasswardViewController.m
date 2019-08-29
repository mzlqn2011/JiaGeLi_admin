//
//  AdminFindPasswardViewController.m
//  JiaGeLi_admin
//
//  Created by LTY on 2019/8/29.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AdminFindPasswardViewController.h"
#import "UIButton+SYDFixMultiClick.h"
@interface AdminFindPasswardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//手机号输入
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;//密码输入
@property (weak, nonatomic) IBOutlet UITextField *surePwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *codeCheckBtn;//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@end

@implementation AdminFindPasswardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureBtn.layer.cornerRadius = 24.5;
}

- (IBAction)backClick:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)sureClick:(id)sender {
    if (!TR_isEexist(self.phoneTextField.text)) {
        [SVProgressHUD displayErrorWithStatus:@"手机号不能为空"];
        return;
    }
    if ([self.phoneTextField.text jk_isMobileNumberClassification] == NO) {
        [SVProgressHUD displayInfoWithStatus:@"请输入正确的电话号码"];
        return;
    }
    if (!TR_isEexist(self.pwdTextField.text)) {
        [SVProgressHUD displayErrorWithStatus:@"密码不能为空"];
        return;
    }
    if (![self.pwdTextField.text isEqualToString:self.surePwdTextField.text]) {
        [SVProgressHUD displayInfoWithStatus:@"设置密码不一致"];
        return;
    }
    if ([TRClassHelper checkCode:self.codeTextField.text]) {
        
        [self requestFindPassword];
    }
    
}
- (IBAction)actionGetCode {
    //判断用户是否输入手机号码 手机号码是否正确
    if (self.phoneTextField.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入电话号码"];
    }else if ([self.phoneTextField.text jk_isMobileNumberClassification] == NO){
        [SVProgressHUD displayInfoWithStatus:@"请输入正确的电话号码"];
    }else{
        [self requestCheckPhone];//验证手机号码是否注册
        
    }
}

#pragma mark - requests
/**
 验证手机号码是否注册
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestCheckPhone {
    [[DataRequestManager sharedManager]requestCheckPhone:@{@"tel":self.phoneTextField.text} success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (statusCode == 100) {
            //说明格式正确,可以进行接收验证码的操作
            [self requestGetVerificationCode];
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                self.codeCheckBtn.enabled = NO;
                self.codeCheckBtn.userInteractionEnabled = NO;
                [self.codeCheckBtn startWithDuration:59 running:^(UIButton *button, NSInteger totalTime, NSInteger leftTime) {
                    [button setTitle:[NSString stringWithFormat:@"%ld”重新获取",(long)leftTime] forState:UIControlStateNormal];
                } finishedBlock:^(UIButton *button) {
                    [button setTitle:@"重新获取" forState:UIControlStateNormal];
                    button.enabled = YES;
                    button.userInteractionEnabled = YES;
                    
                }];
                //让电话号码框结束编辑状态,验证码输入框进入编辑状态
                [self.phoneTextField resignFirstResponder];
                [self.codeTextField becomeFirstResponder];
            });
            
        }else{
            
            [SVProgressHUD displayErrorWithStatus:@"手机号未注册"];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)requestGetVerificationCode {
    [TRClassHelper getCodeChange:self.phoneTextField.text];
}
- (void)requestFindPassword{
    NSMutableDictionary *paramterDic = [[NSMutableDictionary alloc]init];
    [paramterDic setObject:self.phoneTextField.text forKey:@"tel"];
    //    NSString *md5Psw = [NSString md5:self.phoneTextField.text];
    //    [paramterDic setObject:md5Psw forKey:@"password"];
    [paramterDic setObject:self.codeTextField.text forKey:@"code"];
    [[DataRequestManager sharedManager]requestFindPassword:paramterDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
            [self requestModifyPassword];
            
        } else {
            [SVProgressHUD displayErrorWithStatus:jsonDic[NetWork_Msg]];
        }
    } failure:^( NSError *error) {
        [SVProgressHUD displayErrorWithStatus:@"找回密码失败"];
    }];
}
- (void)requestModifyPassword {
    NSMutableDictionary *paramterDic = [[NSMutableDictionary alloc]init];
    [paramterDic setObject:self.phoneTextField.text forKey:@"tel"];
    //    NSString *md5Psw = [NSString md5:self.phoneTextField.text];
    //    [paramterDic setObject:md5Psw forKey:@"password"];
    [paramterDic setObject:self.surePwdTextField.text forKey:@"password"];
    
    [[DataRequestManager sharedManager]requestChangePassword:paramterDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (self.findPasswardSuccess) {
                    self.findPasswardSuccess(paramterDic);
                }
                [SVProgressHUD displayErrorWithStatus:@"找回密码成功"];
                [self backClick:nil];
            });
        } else {
            [SVProgressHUD displayErrorWithStatus:jsonDic[NetWork_Msg]];
        }
    } failure:^( NSError *error) {
        [SVProgressHUD displayErrorWithStatus:@"找回密码失败"];
    }];
}
@end
