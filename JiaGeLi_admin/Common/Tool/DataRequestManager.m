//
//  DataRequestManager.m
//  JiaGeLi
//
//  Created by mac on 2019/7/23.
//  Copyright © 2019 apple. All rights reserved.
//

#import "DataRequestManager.h"

@implementation DataRequestManager

+ (instancetype)sharedManager
{
    static id requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [[super allocWithZone:NULL] init];
    });
    return requestManager;
}

#pragma mark - Get请求
- (void)GETRequestWithUrl:(NSString *)url parameters:(id)parameters success:(RequestSuccess)success failed:(RequestFailed)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer  = [AFJSONResponseSerializer serializer];
    manager.requestSerializer   = [AFJSONRequestSerializer serializer];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"app/json",@"text/plain", nil];
    
    //设置请求头
    [self setRequestHeader:manager];
    if ([url hasPrefix:@"http"] == YES) {//测试
        url = url;
    }else{
        url = [RootUrl stringByAppendingString:url];
    }
    NSLog(@"\n————————请求URL(GET):%@ 参数:%@", url, parameters);
    [manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //转化成字典类型
        NSDictionary *jsonDic = [self dictionaryWithResponseObj:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger statusCode = [jsonDic[@"code"] integerValue];
            if (statusCode == 200 ) {
                statusCode = 200;
            }
            success(jsonDic, statusCode);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
    }];
}

#pragma mark - Post请求
- (void)POST2RequestWithUrl:(NSString *)url parameters:(id)parameters success:(RequestSuccess)success failed:(RequestFailed)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //这时候请求体参数不是json
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //设置请求头
    [self setRequestHeader:manager];
    if ([url hasPrefix:@"http"] == YES) {//测试
        url = url;
    }else{
        url = [RootUrl stringByAppendingString:url];
    }
    NSLog(@"\n————————请求URL(POST):%@ 参数:%@", url, parameters);
    
    [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //在这里写入表单参数
        if ([parameters isKindOfClass:kNSDictionaryClass]) {
            NSDictionary *paramDic = (NSDictionary *)parameters;
            for (NSString *key in paramDic) {
                id value = paramDic[key];
                NSString *strValue = nil;
                if ([value isKindOfClass:[NSString class]]) {
                    strValue = value;
                } else {
                    strValue = ((NSNumber *)value).stringValue;
                }
                [formData appendPartWithFormData:[strValue dataUsingEncoding:NSUTF8StringEncoding] name:key];
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *jsonDic = [self dictionaryWithResponseObj:responseObject];
        NSInteger status = [jsonDic[@"code"] integerValue];
        success(jsonDic, status);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        debugMethod();
    }];
   
}

- (void)POSTRequestWithUrl:(NSString *)url parameters:(id)parameters success:(RequestSuccess)success failed:(RequestFailed)fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer  = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer   = [AFJSONRequestSerializer serializer];
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", @"application/javascript", @"text/js", nil];
    
    //设置请求头
    [self setRequestHeader:manager];
    if ([url hasPrefix:@"http"] == YES) {//测试
        url = url;
    }else{
        url = [RootUrl stringByAppendingString:url];
    }
    NSLog(@"\n————————请求URL(POST):%@ 参数:%@", url, parameters);
    [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        //progress
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *jsonDic = [self dictionaryWithResponseObj:responseObject];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSInteger status = [jsonDic[@"code"] integerValue];
            if (status == 0) {
                
            }
            success(jsonDic, status);
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        fail(error);
        NSDictionary *userInfo = error.userInfo;
        NSObject *data = [userInfo objectForKey:@"com.alamofire.serialization.response.error.data"];
//        [AppHelper toast:@"网络异常请重试"];
    }];
}

#pragma mark 设置请求头
- (void)setRequestHeader:(AFHTTPSessionManager *)manager
{
//    NSString *version = [Common getAppVersion];
//    NSString *token   = [Common getSessionToken];
//    NSString *city    = [Common getCurrentCity];
//    [manager.requestSerializer setValue:version forHTTPHeaderField:@"x-yhc"];
//    [manager.requestSerializer setValue:city    forHTTPHeaderField:@"x-city"];
//    [manager.requestSerializer setValue:token   forHTTPHeaderField:@"x-token"];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded"  forHTTPHeaderField:@"Content-Type"];
}

#pragma mark - 不管结果是什么都转化成字典
- (NSDictionary *)dictionaryWithResponseObj:(id)responseObject
{
    NSDictionary *jsonDic = nil;
    if ([responseObject isKindOfClass:[NSData class]]) {
        //post结果
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        jsonDic  = [NSString dictionaryWithJsonString:string];
    } else if ([responseObject isKindOfClass:[NSString class]]) {
        jsonDic = [NSString dictionaryWithJsonString:responseObject];
    } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
        //get基本是这个
        jsonDic = responseObject;
    }
    
    if (![jsonDic isKindOfClass:[NSDictionary class]]) {
        jsonDic = @{};
    }
    return jsonDic;
}
/**
 验证手机号码是否注册
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestCheckPhone:(NSDictionary *)pramas
success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                  failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"telCheck"];;
    [self GETRequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**
 会员登录
 @param tel password
 @param success 成功
 @param failure 失败
 */
- (void)login:(NSDictionary *)pramas
                    success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                    failure:(void (^)(NSError *error))failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"login"];;
    [self POST2RequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
         failure(error);
    }];

}

/**
 发送注册验证码
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestGetCode:(NSDictionary *)pramas
               success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
               failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"sendRegCode"];;
    [self GETRequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 发送找回密码验证码
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestSendChangeGetCode:(NSDictionary *)pramas
               success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
               failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"sendfindPassCode"];;
    [self GETRequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 会员注册
 @param tel password password
 @param success 成功
 @param failure 失败
 */
- (void)regist:(NSDictionary *)pramas
       success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
       failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"regist"];;
    [self POST2RequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**
 找回密码第一步
 
 @param tel code
 @param success 成功
 @param failure 失败
 */
- (void)requestFindPassword:(NSDictionary *)pramas
                    success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                    failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"findPassword"];;
    [self POST2RequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**
 找回密码第二步
 
 @param tel
 @param success 成功
 @param failure 失败
 */
- (void)requestChangePassword:(NSDictionary *)pramas
                    success:(void (^)(id  _Nonnull jsonDic, NSInteger statusCode))success
                    failure:(void (^)(NSError *error))failure{
    NSString *urlStr = [NSString stringWithFormat:@"%s%@", kUserUrl, @"changePassword"];;
    [self POST2RequestWithUrl:urlStr parameters:pramas success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        success(jsonDic,statusCode);
    } failed:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
