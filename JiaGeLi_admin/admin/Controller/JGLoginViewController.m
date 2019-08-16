//
//  JGLoginViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/7/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "JGLoginViewController.h"
#import "HomeAdminViewController.h"
#import "CNavigationViewController.h"
#import "UIButton+SYDFixMultiClick.h"
#import "NSString+JKNormalRegex.h"
#import "JGLFindPasswardViewController.h"
#import "LoginModel.h"
#import "TRClassHelper.h"
@interface JGLoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *back;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;//手机号输入
@property (weak, nonatomic) IBOutlet UITextField *codeTextField;//密码输入
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;//
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;//
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIView *registerView;
@property (weak, nonatomic) IBOutlet UIView * line;
@property (weak, nonatomic) IBOutlet UIView * line2;
@property (nonatomic, copy) NSString *userName;//用户名  手机号
@property (weak, nonatomic) IBOutlet UIButton *codeCheckBtn;//获取验证码
@property (weak, nonatomic) IBOutlet UIButton *topBarLogin;
@property (weak, nonatomic) IBOutlet UIButton *topBarRegister;
@property (weak, nonatomic) IBOutlet UITextField *registerPhoneTextField;//手机号输入
@property (weak, nonatomic) IBOutlet UITextField *registerCodeTextField;//验证码输入
@property (weak, nonatomic) IBOutlet UITextField *registerPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerSurePwdTextField;
@end

@implementation JGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)initUI{
    self.whiteView.layer.cornerRadius = 10;
    self.whiteView.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
    self.whiteView.layer.shadowOffset = CGSizeMake(0,1);
    self.whiteView.layer.shadowOpacity = 1;
    self.whiteView.layer.shadowRadius = 20;
    self.loginBtn.layer.cornerRadius = 24.5;
    self.registerBtn.layer.cornerRadius = 24.5;
    [self.phoneTextField addTarget:self action:@selector(actionPhoneTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.codeTextField addTarget:self action:@selector(actionPhoneTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.registerPhoneTextField addTarget:self action:@selector(actionRegisterPhoneTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
     [self.registerCodeTextField addTarget:self action:@selector(actionRegisterPhoneTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
     [self.registerPwdTextField addTarget:self action:@selector(actionRegisterPhoneTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
     [self.registerSurePwdTextField addTarget:self action:@selector(actionRegisterPhoneTextFieldDidChange) forControlEvents:UIControlEventEditingChanged];
}

- (void)actionRegisterPhoneTextFieldDidChange{
    
           if (_registerPhoneTextField.text.length >= 11) {
            _registerPhoneTextField.text = [_registerPhoneTextField.text substringToIndex:11];
            self.codeCheckBtn.enabled = YES;
            
        }else{
            self.codeCheckBtn.enabled = NO;
        }
    if (_registerCodeTextField.text.length >0 &&_registerPwdTextField.text.length >0&&_registerSurePwdTextField.text.length >0) {
        self.registerBtn.enabled = YES;
        [self.registerBtn setBackgroundColor:kThemeColor];
        
    }else{
        self.registerBtn.enabled = NO;
        [self.registerBtn setBackgroundColor:kDeflutGaryColor];
    }

}
- (void)actionPhoneTextFieldDidChange{
     if (_codeTextField.text.length >0 &&_phoneTextField.text.length >0) {
         self.loginBtn.enabled = YES;
         [self.loginBtn setBackgroundColor:kThemeColor];
         
     }else{
         self.loginBtn.enabled = NO;
         [self.loginBtn setBackgroundColor:kDeflutGaryColor];
     }
    if (_phoneTextField.text.length >= 11) {
        _phoneTextField.text = [_phoneTextField.text substringToIndex:11];
    }
   
}

#pragma mark - 登录/注册按钮
- (IBAction)loginBtnClick:(UIButton *)sender {
#if DEBUG
    self.phoneTextField.text = @"18316447658";
    self.codeTextField.text = @"123456";
#endif
    if (self.phoneTextField.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入电话号码"];
        return;
    }
    if ([self.phoneTextField.text jk_isMobileNumberClassification] == NO){
        [SVProgressHUD displayInfoWithStatus:@"请输入正确的电话号码"];
        return;
    }
    if (self.codeTextField.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入密码"];
        return;
    }
    self.userName = self.phoneTextField.text;

    [self requsetLogin];

}

- (IBAction)registerBtnClick:(UIButton *)sender {
    if (self.registerPhoneTextField.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入电话号码"];
        return;
    }
    if ([self.registerPhoneTextField.text jk_isMobileNumberClassification] == NO){
        [SVProgressHUD displayInfoWithStatus:@"请输入正确的电话号码"];
        return;
    }
    if (self.registerPwdTextField.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请设置密码"];
        return;
    }
    if (![self.registerPwdTextField.text isEqualToString:self.registerSurePwdTextField.text]) {
        [SVProgressHUD displayInfoWithStatus:@"设置密码不一致"];
        return;
    }
    if ([TRClassHelper checkCode:self.registerCodeTextField.text]) {
      
        [self requsetRegist];
    }
}
- (IBAction)forgotBtnClick:(UIButton *)sender {
    JGLFindPasswardViewController * vc = [[JGLFindPasswardViewController alloc]init];
    [self presentViewController:vc animated:YES completion:NULL];
}
- (IBAction)actionGetCode:(UIButton *)sender  {
    
    //判断用户是否输入手机号码 手机号码是否正确
    if (self.registerPhoneTextField.text.length == 0) {
        [SVProgressHUD displayInfoWithStatus:@"请输入电话号码"];
    }else if ([self.registerPhoneTextField.text jk_isMobileNumberClassification] == NO){
        [SVProgressHUD displayInfoWithStatus:@"请输入正确的电话号码"];
    }else{
         [self requestCheckPhone];//验证手机号码是否注册
       
    }
}
- (IBAction)changeBtnClick:(UIButton *)sender {
    if (sender.tag == 1) {
       self.registerView.hidden = YES;
        self.loginView.hidden = NO;
        self.line.backgroundColor = kThemeColor;
        self.line2.backgroundColor = kWhiteColor;

    }else {
        self.line2.backgroundColor = kThemeColor;
        self.line.backgroundColor = kWhiteColor;
        self.loginView.hidden = YES;
        self.registerView.hidden = NO;

    }
    self.topBarLogin.selected = NO;
    self.topBarRegister.selected = NO;
    sender.selected = YES ;
}

- (IBAction)back:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
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
        if (NetWork_Success) {
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
                [self.registerPhoneTextField resignFirstResponder];
                [self.registerCodeTextField becomeFirstResponder];
            });
           
        }else{
            [SVProgressHUD displayErrorWithStatus:NetWork_Msg];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)requestGetVerificationCode {
    [TRClassHelper getCode:self.registerPhoneTextField.text];
}
- (void)requestCommitVerificationCode {
    //提交验证码
    if ([TRClassHelper checkCode:self.registerCodeTextField.text]) {
        self.userName = self.registerPhoneTextField.text;
       
        [self requsetLogin];
    }
}

- (void)requsetLogin{
    //放弃第一响应者
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param trmSetObject:self.phoneTextField.text forKey:@"tel"];
    [param trmSetObject:self.codeTextField.text forKey:@"password"];
    [[DataRequestManager sharedManager] login:param success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
          LoginModel *loginModel = [LoginModel mj_objectWithKeyValues:jsonDic[NetWork_Data]];
              [JGLSingle login:loginModel];
            if(JGLSingle.userModel.safe_code){
                NSString * s = [NSString stringWithFormat:@"%@+%@",JGLSingle.userModel.seller_id,JGLSingle.userModel.safe_code];

                JGLSingle.userModel.auth_token = [MD5Encrypt MD5ForLower32Bate:s];
            }else{
                JGLSingle.userModel.auth_token = @"90c58ac60dccbf4b1810d947e1407488";
            }
           
            HomeAdminViewController *rootVc = [[HomeAdminViewController alloc] init];
            CNavigationViewController *navigationViewController = [[CNavigationViewController alloc] initWithRootViewController:rootVc];
            kWindow.rootViewController = navigationViewController;
        } else {
              [SVProgressHUD displayInfoWithStatus:jsonDic[NetWork_Msg]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)requsetRegist{
    //放弃第一响应者
    [self.phoneTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param trmSetObject:self.registerPhoneTextField.text forKey:@"tel"];
    [param trmSetObject:self.registerCodeTextField.text forKey:@"code"];
    [param trmSetObject:self.registerSurePwdTextField.text forKey:@"password"];
    [[DataRequestManager sharedManager] regist:param success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
            [SVProgressHUD showSuccessWithStatus:@"注册成功"];
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                self.phoneTextField.text =  self.registerPhoneTextField.text;
                [self changeBtnClick:self.topBarLogin];
            });
            
        }else{
            [SVProgressHUD displayErrorWithStatus:NetWork_Msg];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
