//
//  OrderManageViewController.m
//  JiaGeLi_admin
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "OrderManageVC.h"

@interface OrderManageVC ()

@end

@implementation OrderManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self requestData];

}

- (void)requestData
{
    NSString *authToken = @"90c58ac60dccbf4b1810d947e1407488";
    NSString *url = [NSString stringWithFormat:@"%s%@", kUserUrl, @"orderList"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:@"1" forKey:@"seller_id"]; //JGLSingle.userModel.seller_id
    [paramDic setObject:authToken forKey:@"auth_token"];
    [paramDic setObject:@(100) forKey:@"status"];
    
    [kDataRequestManager POST2RequestWithUrl:url parameters:paramDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if ([jsonDic isKindOfClass:kNSDictionaryClass]) {
            NSDictionary *dataDic = jsonDic[@"data"];
        }
            
    } failed:^(NSError * _Nonnull error) {
        
    }];
}


@end
