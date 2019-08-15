//
//  CheckCodeViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CheckCodeViewController.h"

@interface CheckCodeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeCheckBtn;//获取验证码
@end

@implementation CheckCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.codeCheckBtn.layer.borderColor = kGrayBgColor.CGColor;
    self.codeCheckBtn.layer.borderWidth = 1.0;
    self.codeCheckBtn.layer.cornerRadius = 3;
    self.codeCheckBtn.layer.masksToBounds = YES;
   self.nextBtn.layer.cornerRadius = 6;
}

- (IBAction)nextClick:(id)sender {
}

- (IBAction)codeClick:(id)sender {
}

@end
