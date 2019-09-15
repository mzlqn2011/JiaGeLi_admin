//
//  ApplicationViewController.m
//  JiaGeLi_admin
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ApplicationViewController.h"

@interface ApplicationViewController ()

@end

@implementation ApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (void)initUI
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(20), kRealValue(78), kRealValue(100), kRealValue(23))];
    titleLabel.textColor = kBlackColor;
    titleLabel.font = boldFont(23);
    titleLabel.text = @"填写申请";
    [self.view addSubview:titleLabel];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(kRealValue(20), titleLabel.bottom, kRealValue(100), kRealValue(23))];
    tipLabel.textColor = kRedColor;
    tipLabel.text = @"注：为了便于审核，需要您如实填写";
    tipLabel.font = font(18);
    [self.view addSubview:tipLabel];
    
    

    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
