//
//  BaseModel.m
//  联合易购
//
//  Created by pure on 2017/4/28.
//  Copyright © 2017年 pure. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

-(instancetype)initWithDictionay:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        // 尽量用 self. 去赋值 符合内存管理的规则
        
        // 根据字典里的key值的字段名 去寻找对应字段名字的属性 比如
        // 比如 dic 有一个 key值 为 tid 就会给 self.tid 赋值

        if (dic) {
            [self setValuesForKeysWithDictionary:dic];
        }

    }
    return self;
}

// 使用 setValuesForKeysWithDictionary： 这个方法 给属性赋值 会紧接着调用这个方法 key 是字典的key值 value 是key值 在字典里对应的值
-(void)setValue:(id)value forKey:(NSString *)key
{
    if (value) {
        [super setValue:value forKey:key];
    }
}

//  如果字典里的 key 值 没有对应的属性 会调用这个方法 (接口返回字段中有关键字id时的处理办法)
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"Id"]){
        self.ID = [value integerValue];
    }
}

 

@end
