//
//  NSMutableDictionary+Extension.h
//  FirstNumCar
//
//  Created by apple on 2019/5/8.
//  Copyright © 2019 can can. All rights reserved.
//
//#import "TRClassHelper.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (Extension)

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key;
- (void)trmSetObject:(id)anObject forKey:(id<NSCopying>)aKey;
@end

NS_ASSUME_NONNULL_END
