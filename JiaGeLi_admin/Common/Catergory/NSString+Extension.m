//
//  NSString+Extension.m
//  liuMuStore
//
//  Created by 邓财勇 on 16/1/12.
//  Copyright © 2016年 cynetwork. All rights reserved.
//

#import "NSString+Extension.h"
#import <sys/utsname.h> 

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(NSString *)ReturnCutStrWithChat:(NSString *)Chat andLength:(NSInteger)Length{
    
    NSString *StrRetuen = [[self substringToIndex:Length] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@",Chat] withString:@" "];
    return StrRetuen;
}

//邮箱
+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
} 

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(16[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL)validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
//    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}



//以下验证不计算长度
//1、验证字符串
- (BOOL)validateNickname:(NSString *)nickname {
    // 不包含特殊字符
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    NSString *nicknameRegex = @".*[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]+.*";
    NSPredicate *nicknamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", nicknameRegex];
    return ![nicknamePredicate evaluateWithObject:nickname];
}

//2、验证密码
- (BOOL)validatePassword:(NSString *)password {
    // 特殊字符包含`、-、=、\、[、]、;、'、,、.、/、~、!、@、#、$、%、^、&、*、(、)、_、+、|、?、>、<、"、:、{、}
    // 必须包含数字和字母，可以包含上述特殊字符。
    // 依次为（如果包含特殊字符）
    // 数字 字母 特殊
    // 字母 数字 特殊
    // 数字 特殊 字母
    // 字母 特殊 数字
    // 特殊 数字 字母
    // 特殊 字母 数字
    NSString *passWordRegex = @"(\\d+[a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|([a-zA-Z]+\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*)|(\\d+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+)|([a-zA-Z]+[-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*\\d+[a-zA-Z]+)|([-`=\\\[\\];',./~!@#$%^&*()_+|{}:\"<>?]*[a-zA-Z]+\\d+)";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}


//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号验证
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"(^\\d{15}$)|(^\\d{17}(\\d|X|x)$)";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//验证身份证号码
+ (BOOL)checkIdentityCardNo:(NSString*)cardNo
{
    if (cardNo.length != 18) {
        return  NO;
    }
    NSArray* codeArray = [NSArray arrayWithObjects:@"7",@"9",@"10",@"5",@"8",@"4",@"2",@"1",@"6",@"3",@"7",@"9",@"10",@"5",@"8",@"4",@"2", nil];
    NSDictionary* checkCodeDic = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"1",@"0",@"X",@"9",@"8",@"7",@"6",@"5",@"4",@"3",@"2", nil]  forKeys:[NSArray arrayWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil]];
    
    NSScanner* scan = [NSScanner scannerWithString:[cardNo substringToIndex:17]];
    
    int val;
    BOOL isNum = [scan scanInt:&val] && [scan isAtEnd];
    if (!isNum) {
        return NO;
    }
    int sumValue = 0;
    
    for (int i =0; i<17; i++) {
        sumValue+=[[cardNo substringWithRange:NSMakeRange(i , 1) ] intValue]* [[codeArray objectAtIndex:i] intValue];
    }
    NSString* strlast = [checkCodeDic objectForKey:[NSString stringWithFormat:@"%d",sumValue%11]];
    
    if ([strlast isEqualToString: [[cardNo substringWithRange:NSMakeRange(17, 1)]uppercaseString]]) {
        return YES;
    }
    return  NO;
}

+ (BOOL)theLastIsX:(NSString *)IDNumber {
    NSMutableArray *IDArray = [NSMutableArray array];
    for (int i = 0; i < 17; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *subString = [IDNumber substringWithRange:range];
        [IDArray addObject:subString];
    }
    NSArray *coefficientArray = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    int sum = 0;
    for (int i = 0; i < 17; i++) {
        int coefficient = [coefficientArray[i] intValue];
        int ID = [IDArray[i] intValue];
        sum += coefficient * ID;
    }
    if (sum % 11 == 2) return YES;
    else return NO;
}

+ (BOOL) connectedToNetwork
{
    // Create zero addy
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

+ (NSString *)getUrl:(NSString*)url width:(NSInteger)width height:(NSInteger)height
{
    NSString *w = @"?w=";
    NSString *h = @"&h=";
    NSString *mode = @"&mode=crop";
    NSString *newUrl =  [url stringByAppendingFormat:@"%@%ld%@%ld%@",w,(long)width,h,height,mode];
    return newUrl;
}

+ (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

+ (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

+ (BOOL)isPureString:(NSString *)string {
    if ([string isKindOfClass:[NSString class]]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] > 0) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}
- (NSString *)isPureNULL{
    if (![NSString isPureString:self]) {
        return @"";
    }
    return self;
}
+ (NSString *)getNumberWithDigit:(NSString *)digit DecimalCount:(NSInteger)decimalCount {
    if (![NSString isPureString:digit]) {
        digit = @"0";
    }
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                             scale:decimalCount
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    NSDecimalNumber *totalAmount = [NSDecimalNumber decimalNumberWithString:digit];
    NSDecimalNumber *resultDN = [totalAmount decimalNumberByRoundingAccordingToBehavior:handler];
    
    NSMutableString *result = [NSMutableString string];
    
    NSString *numberStr = resultDN.stringValue;
    
    if ([numberStr containsString:@"."]) {
        //小数部分
        NSString *floatStr = [[numberStr componentsSeparatedByString:@"."] lastObject];
        
        if (floatStr.length == decimalCount) {
            [result appendString:numberStr];
            
            return result;
        } else { //小数点后面位数不足需补0
            [result appendString:numberStr];
            
            for (int i = 0; i < (decimalCount - floatStr.length); i ++) {
                [result appendString:@"0"];
            }
            return result;
        }
    } else {
        if (decimalCount == 0) {
            [result appendString:[NSString stringWithFormat:@"%@",numberStr]];
        } else {
            [result appendString:[NSString stringWithFormat:@"%@.",numberStr]];
            
            for (int i = 0; i < decimalCount; i ++) {
                [result appendString:@"0"];
            }
        }
        return result;
    }
}

+ (NSString *)getRoundingNumberWithDigit:(NSString *)digit DecimalCount:(NSInteger)decimalCount {
    if (![NSString isPureString:digit]) {
        digit = @"0";
    }
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain
                                                                                             scale:decimalCount
                                                                                  raiseOnExactness:NO
                                                                                   raiseOnOverflow:NO
                                                                                  raiseOnUnderflow:NO
                                                                               raiseOnDivideByZero:YES];
    NSDecimalNumber *totalAmount = [NSDecimalNumber decimalNumberWithString:digit];
    NSDecimalNumber *resultDN = [totalAmount decimalNumberByRoundingAccordingToBehavior:handler];
    
    NSMutableString *result = [NSMutableString string];
    
    NSString *numberStr = resultDN.stringValue;
    
    if ([numberStr containsString:@"."]) {
        //小数部分
        NSString *floatStr = [[numberStr componentsSeparatedByString:@"."] lastObject];
        
        if (floatStr.length == decimalCount) {
            [result appendString:numberStr];
            
            return result;
        } else { //小数点后面位数不足需补0
            [result appendString:numberStr];
            
            for (int i = 0; i < (decimalCount - floatStr.length); i ++) {
                [result appendString:@"0"];
            }
            return result;
        }
    } else {
        if (decimalCount == 0) {
            [result appendString:[NSString stringWithFormat:@"%@",numberStr]];
        } else {
            [result appendString:[NSString stringWithFormat:@"%@.",numberStr]];
            
            for (int i = 0; i < decimalCount; i ++) {
                [result appendString:@"0"];
            }
        }
        return result;
    }
}

+ (NSString *)getNumberWithDividend:(NSString *)dividend Divider:(NSString *)divider {
    if (![NSString isPureString:dividend]) {
        dividend = @"0";
    }
    
    if (![NSString isPureString:divider]) {
        return @"0";
    }
    
    if ([divider floatValue] == 0) {
        return @"0";
    }
    
    NSDecimalNumber *dividendNum = [NSDecimalNumber decimalNumberWithString:dividend];
    NSDecimalNumber *dividerNum = [NSDecimalNumber decimalNumberWithString:divider];
    NSDecimalNumber *result = [dividendNum decimalNumberByDividingBy:dividerNum]; // 所有积分除以比例，得出可抵扣的金额
    
    return result.stringValue;
}

+ (NSString *)removeWhiteSpaceWithText:(NSString *)text {
    if ([NSString isPureString:text]) {
        text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];// 英文空格
        text = [text stringByReplacingOccurrencesOfString:@"　" withString:@""];// 中文空格
    } else {
        text = @"";
    }
    return text;
}

- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

#pragma mark -- 中文GBK转字符串
+ (NSString *)GBKtranscoding:(NSString *)string
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //GBK转码
    NSString *first=[string stringByAddingPercentEscapesUsingEncoding:enc];
    return first;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}


@end
