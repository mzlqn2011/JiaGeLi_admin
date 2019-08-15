//
//  UIButton+SYDFixMultiClick.h
//  ZuoGongJiao
//
//  Created by lantaiyuan on 2017/10/24.
//  Copyright © 2017年 lantaiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RunBlock)(UIButton *button,NSInteger totalTime,NSInteger leftTime);
typedef void(^EndBlock)(UIButton *button);

@interface UIButton (SYDFixMultiClick)

@property (nonatomic, assign) NSTimeInterval eventTimeInterval; // 重复点击的间隔


/**
 倒计时按钮
 
 @param duration 总时间
 @param runBlock 倒计时期间回调
 @param endBlock 倒计时结束回调
 */
-(void)startWithDuration:(NSInteger)duration running:(RunBlock)runBlock finishedBlock:(EndBlock)endBlock;

@end
