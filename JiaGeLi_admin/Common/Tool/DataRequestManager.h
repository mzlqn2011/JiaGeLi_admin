//
//  DataRequestManager.h
//  JiaGeLi
//
//  Created by mac on 2019/7/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Common.h"
//39.98.214.123
//47.104.143.166
NS_ASSUME_NONNULL_BEGIN
#define Domian  @"http://39.98.214.123"
#define RootUrl @"http://39.98.214.123/jzapp/api/" //地址
//#define kProductUrl "Product.php?action="
#define kUserUrl    "Seller.php?action="
#define kServiceUrl    "Service.php?action="

#define NetWork_Success [jsonDic[@"code"]integerValue] == 0
#define NetData_Eexist TR_isEexist(jsonDic[NetWork_Data])
#define NetMsg_Eexist TR_isEexist(jsonDic[NetWork_Msg])
#define NetWork_Data @"data"
#define NetWork_Msg @"msg"
#define MsgCode @"MsgCode"

@interface DataRequestManager : NSObject

typedef void (^RequestSuccess) (id jsonDic, NSInteger statusCode);
typedef void (^RequestFailed) (NSError *error);

@property(nonatomic, strong) AFHTTPSessionManager *sessionManager;

/**
 创建的请求的超时间隔（以秒为单位），此设置为全局统一设置一次即可，默认超时时间间隔为30秒。
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

@property (nonatomic, copy) RequestSuccess requestSuccess;
@property (nonatomic, copy) RequestFailed requestFailed;

+ (instancetype)sharedManager;

- (void)GETRequestWithUrl:(NSString *)url parameters:(id)parameters success:(RequestSuccess)success failed:(RequestFailed)fail;

- (void)POSTRequestWithUrl:(NSString *)url parameters:(id)parameters success:(RequestSuccess)success failed:(RequestFailed)fail;

- (void)POST2RequestWithUrl:(NSString *)url parameters:(id)parameters success:(RequestSuccess)success failed:(RequestFailed)fail;
/**
 会员登录
 @param tel password
 @param success 成功
 @param failure 失败
 */
- (void)login:(NSDictionary *)pramas
      success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
      failure:(void (^)(NSError *error))failure;
/**
 验证手机号码是否注册
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestCheckPhone:(NSDictionary *)pramas
                  success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                  failure:(void (^)(NSError *error))failure;
/**
 发送注册验证码
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestGetCode:(NSDictionary *)pramas
               success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
               failure:(void (^)(NSError *error))failure;

/**
会员注册
 @param tel password password
 @param success 成功
 @param failure 失败
 */
- (void)regist:(NSDictionary *)pramas
               success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
               failure:(void (^)(NSError *error))failure;
/**
 发送更换手机验证码
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestSendChangeGetCode:(NSDictionary *)pramas
                         success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                         failure:(void (^)(NSError *error))failure;
/**
 找回密码第一步

 @param tel code
 @param success 成功
 @param failure 失败
 */
- (void)requestFindPassword:(NSDictionary *)pramas
                         success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                         failure:(void (^)(NSError *error))failure;
/**
 找回密码第二步
 
 @param tel password
 @param success 成功
 @param failure 失败
 */
- (void)requestChangePassword:(NSDictionary *)pramas
                      success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                      failure:(void (^)(NSError *error))failure;
@end

NS_ASSUME_NONNULL_END
