//
//  LoginModel.h
//  JiaGeLi
//
//  Created by LTY on 2019/7/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "YLBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : YLBaseModel
@property (nonatomic, copy) NSString *seller_id;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *company_name;//店铺名称
@property (nonatomic, copy) NSString *logo;//店铺图片地址
@property (nonatomic, copy) NSString *addr_code;//地址编码
@property (nonatomic, copy) NSString *safe_code;//安全码，认证时候用到
@property (nonatomic, copy) NSString *addr;//详细地址
@property (nonatomic, copy) NSString *type;//卖家类型（0物业自营，1三方卖家）
@property (nonatomic, copy) NSString *src;//头像地址
@property (nonatomic, copy) NSString *thumb_src;//头像略缩地址
@property (nonatomic, copy) NSString *auth_token;
@end

NS_ASSUME_NONNULL_END
