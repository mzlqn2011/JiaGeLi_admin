//
//  Common.h
//  JiaGeLi
//
//  Created by mac on 2019/8/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Common : NSObject

+ (BOOL)isLogin;

+ (NSArray *)getDicArrayFromArrayDic:(NSDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
