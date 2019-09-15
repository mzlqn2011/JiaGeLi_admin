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
//    NSString *authToken = @"90c58ac60dccbf4b1810d947e1407488";//12ca7be7d4646d538415e602c6b1b594Ø
    NSString *url = [NSString stringWithFormat:@"%s%@", kUserUrl, @"orderList"];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:JGLSingle.userModel.seller_id forKey:@"seller_id"]; //JGLSingle.userModel.seller_id
    [paramDic setObject:JGLSingle.userModel.auth_token forKey:@"auth_token"];
    [paramDic setObject:@(100) forKey:@"status"];
    [paramDic setObject:@(0) forKey:@"page"];
    [paramDic setObject:@(10) forKey:@"num"];
    
    [kDataRequestManager POST2RequestWithUrl:url parameters:paramDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if ([jsonDic isKindOfClass:kNSDictionaryClass]) {
            NSDictionary *dataDic = jsonDic[@"data"];
            if ([dataDic isKindOfClass:kNSDictionaryClass]) {
//                NSArray *dicArray = [Common getDicArrayFromArrayDic:dataDic];
                
            }
            
        }
            
    } failed:^(NSError * _Nonnull error) {
        
    }];
}


@end
