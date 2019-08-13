//
//  BaseModel.h
//  联合易购
//
//  Created by pure on 2017/4/28.
//  Copyright © 2017年 pure. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, assign) NSInteger ID;

-(instancetype)initWithDictionay:(NSDictionary *)dic;


@end
