//
//  TRClassHelp.h
//  PinGJByOwnerSide
//
//  Created by LTY on 2017/11/24.
//  Copyright © 2017年 lantaiyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "MapHelper.h"

@interface TRClassHelper : NSObject
+(BOOL)isEexist:(id)object;
+(NSString *)securityString:(id)object;

+(void)getCode:(NSString *)phone ;
+(void)getCodeChange:(NSString *)phone;
+(BOOL)checkCode:(NSString *)code;
//+(NSString *)outBaShiShangChengString:(NSString *)str; // 更换巴士商城名字
// 切换网络
+(void)touchChangeNetwork;
// 点击7次 上传carch日志
+(void)touchUploadCrachLog;

+ (BOOL)checkAudio;
@end
