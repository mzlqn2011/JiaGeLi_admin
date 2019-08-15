//
//  NSString+Extension.h
//  liuMuStore
//
//  Created by 邓财勇 on 16/1/12.
//  Copyright © 2016年 cynetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import <arpa/inet.h>

@interface NSString (Extension)

/**
 *  返回字符串所占用的尺寸
 *
 *  @param font    字体
 *  @param maxSize 最大尺寸
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

-(NSString *)ReturnCutStrWithChat:(NSString *)Chat andLength:(NSInteger)Length;


//邮箱验证
+ (BOOL) validateEmail:(NSString *)email;

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile;

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;


//车型
+ (BOOL) validateCarType:(NSString *)CarType;

//用户名
+ (BOOL) validateUserName:(NSString *)name;


//密码
+ (BOOL) validatePassword:(NSString *)passWord;

//昵称
+ (BOOL) validateNickname:(NSString *)nickname;

//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard;

//验证身份证号码
+(BOOL)checkIdentityCardNo:(NSString*)cardNo;

//判断身份证最后为是否为X
+ (BOOL)theLastIsX:(NSString *)IDNumber;

+ (BOOL) connectedToNetwork;

+ (NSString *)getUrl:(NSString*)url width:(NSInteger)width height:(NSInteger)height;

+ (BOOL)isPureInt:(NSString*)string;

+ (BOOL)isPureFloat:(NSString*)string;
/**
 判断传入的数据类型是否为字符串，且长度大于0
 */
+ (BOOL)isPureString:(NSString *)string;
/**
 将传入的数字字符串，截取小数点后两位，不足补0
 */
+ (NSString *)getNumberWithDigit:(NSString *)digit DecimalCount:(NSInteger)decimalCount;

/**
 将传入的数字字符串，截取小数点后两位(四舍五入)，不足补0
 */
+ (NSString *)getRoundingNumberWithDigit:(NSString *)digit DecimalCount:(NSInteger)decimalCount;

/**
 输入被除数以及除数
 */
+ (NSString *)getNumberWithDividend:(NSString *)dividend Divider:(NSString *)divider;

/**
 去除字符串中的所有空格
 */
+ (NSString *)removeWhiteSpaceWithText:(NSString *)text;


/**
 做空处理
 */
- (NSString *)isPureNULL;

/**
 返回字符串的高度
 */
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;

#pragma mark -- 中文GBK转字符串
+ (NSString *)GBKtranscoding:(NSString *)string;

//jsonString转化为dictionary
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;


@end
