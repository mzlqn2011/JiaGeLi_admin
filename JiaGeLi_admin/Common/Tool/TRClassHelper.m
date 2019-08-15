//
//  TRClassHelp.m
//  PinGJByOwnerSide
//
//  Created by LTY on 2017/11/24.
//  Copyright © 2017年 lantaiyuan. All rights reserved.
//

#import "TRClassHelper.h"
//#import "FileLog.h"

@implementation TRClassHelper
+(BOOL)isEexist:(id)object{
    if ([object isKindOfClass:[NSNull class]] || !object)
        return NO;
    
    else if([object isKindOfClass:[NSString class]]){
        NSString *string  = object;
        NSString *temp = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet ]];
        if (!temp.length || [@"" isEqualToString:temp])
            return NO;
        return YES;
    }
    else if ([object isKindOfClass:[NSNumber class]]) {
        NSNumber *string = object;
        if ([string integerValue] > 0) return YES;
        return NO;
    }
    
    else if([object isKindOfClass:[NSArray class]]){
        if (((NSArray *)object).count )return YES;
        return NO;
    }
    
    else if( [object isKindOfClass:[NSDictionary class]]){
        if (((NSDictionary *)object).count)return YES;
        return NO;
    }
    
    return NO;
}

+(NSString *)securityString:(id)object {
    if ([self isEexist:object]) {
        return object;
    }
    return @"";
}

//+(NSString *)outBaShiShangChengString:(NSString *)str {
//    if ([str isEqualToString:@"巴士商城"]) {
//        return Three_QianWei;
//    }
//    else {
//        return str;
//    }
//}

+(void)getCode:(NSString *)phone {
    
    NSMutableDictionary *paramterDic = [[NSMutableDictionary alloc]init];
    [paramterDic setObject:phone forKey:@"tel"];

    
    [[DataRequestManager sharedManager] requestGetCode:paramterDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (TR_isEexist(jsonDic[NetWork_Data])) {
            [SVProgressHUD displayErrorWithStatus:@"短信已发送"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", jsonDic[NetWork_Data][@"verificationCode"]  ]forKey:MsgCode];
        } else {
            [SVProgressHUD displayErrorWithStatus:jsonDic[NetWork_Msg]];
        }
    } failure:^(NSError *error) {
        
    }];
}
+(void)getCodeChange:(NSString *)phone {
    
    NSMutableDictionary *paramterDic = [[NSMutableDictionary alloc]init];
    [paramterDic setObject:phone forKey:@"tel"];
    
    
    [[DataRequestManager sharedManager] requestSendChangeGetCode:paramterDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
            [SVProgressHUD displayErrorWithStatus:@"短信已发送"];
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@", jsonDic[NetWork_Data][@"verificationCode"]  ] forKey:MsgCode];
        } else if(NetMsg_Eexist) {
            [SVProgressHUD displayErrorWithStatus:jsonDic[NetWork_Msg]];
        }
    } failure:^(NSError *error) {
        
    }];
}

+(BOOL)checkCode:(NSString *)code {
    NSString *mCode =  [[NSUserDefaults standardUserDefaults] objectForKey:MsgCode];
    if (!TR_isEexist(code)) {
        [SVProgressHUD displayErrorWithStatus:@"验证码不能为空"];
        return NO;
    }
    if ([code  isEqualToString:mCode]) {
        return YES;
    } else {
        [SVProgressHUD displayErrorWithStatus:@"验证码错误"];
        return NO;
    }
    return YES;
}

+(void)touchChangeNetwork {
//    NSString *indexString = [[NSUserDefaults standardUserDefaults] objectForKey:RootUrlIndex];
//    if (indexString == nil) {
//        indexString = @"0";
//    } else {
//        NSInteger index = [indexString integerValue];
//        if (index + 1 >= [YMNetworkTool shareTool].rootUrlNames.count) {
//            indexString = @"0";
//        } else {
//            indexString = @(index + 1).stringValue;
//        }
//    }
//    [[NSUserDefaults standardUserDefaults] setObject:indexString forKey:RootUrlIndex];
//
//    NSDictionary *dics = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:RootUrls];
//    NSString *urlName = [YMNetworkTool shareTool].rootUrlNames[[indexString integerValue]];
//    NSString *url =  [dics objectForKey:indexString];
//    [[NSUserDefaults standardUserDefaults] setObject:url forKey:RootUrlKey];
//
//    [SVProgressHUD displayInfoWithStatus:urlName time:0.5];
}

// 点击7次 上传carch日志
+(void)touchUploadCrachLog {
//    NSString *indexString = [self changeIndexWithKey:ZGJ_UploadCrachLog];
//    if ([indexString integerValue] == 7) {
//        [SVProgressHUD displayInfoWithStatus:@"准备上传"];
//        [[FileLog standard] fileUploadLog];
//    }
}

+ (NSString *)changeIndexWithKey:(NSString *)key {
    NSString *indexString = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (indexString != nil) {
        if ([indexString integerValue] == 8) {
            indexString = @"0";
        } else {
            indexString = @([indexString integerValue] + 1).stringValue;
        }
    } else {
        indexString = @"0";
    }
    [[NSUserDefaults standardUserDefaults] setObject:indexString forKey:key];
    return indexString;
}

+ (BOOL)checkAudio {
    BOOL b;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启麦克风
            b = NO;
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
            b = NO;
            break;
        case AVAuthorizationStatusDenied:
            //玩家未授权
            b = NO;
            break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
            b = YES;
            break;
        default:
            break;
    }
    return b;
    
}

@end
