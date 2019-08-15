//
//  Common.m
//  JiaGeLi
//
//  Created by mac on 2019/8/4.
//  Copyright © 2019 apple. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (BOOL)isLogin
{
    return NO;
}

+ (NSArray *)getDicArrayFromArrayDic:(NSDictionary *)dataDic
{
    NSMutableArray *dicArray = nil;
    
    for (NSString *key in dataDic) {
        NSArray *array = dataDic[key];
        if (![array isKindOfClass:kNSArrayClass]) {
            continue;
        }
        
        if (dicArray == nil) {
            dicArray = [NSMutableArray array];
            for (int i = 0; i < array.count; i++) {
                [dicArray addObject:[NSMutableDictionary dictionary]];
            }
        }
        
        NSInteger minCount = MIN(array.count, dicArray.count);
        for (int i = 0; i < minCount; i++) {
            NSMutableDictionary *modelDic = dicArray[i];
            id value = array[i];
            [modelDic setObject:value forKey:key];
        }
    }
    
    return dicArray;
}


@end
