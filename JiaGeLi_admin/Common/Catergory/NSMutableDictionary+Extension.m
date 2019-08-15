//
//  NSMutableDictionary+Extension.m
//  FirstNumCar
//
//  Created by apple on 2019/5/8.
//  Copyright © 2019 can can. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (Extension)

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    [self setValue:@(value) forKey:key];
}
- (void)trmSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (TR_isEexist(anObject)) {
        [self setObject:anObject forKey:aKey];
    }
}
@end
