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
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *sex;//（0男1女）
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *safe_code;//安全码，认证时候用到
@property (nonatomic, copy) NSString *score;//积分
@property (nonatomic, copy) NSString *house_id;//门牌号id(0表示未认证)
@property (nonatomic, copy) NSString *src;//头像地址
@property (nonatomic, copy) NSString *thumb_src;//头像略缩地址
@property (nonatomic, copy) NSString *auth_token;
@end

NS_ASSUME_NONNULL_END
