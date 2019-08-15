//
//  UIButton+SYDFixMultiClick.m
//  ZuoGongJiao
//
//  Created by lantaiyuan on 2017/10/24.
//  Copyright © 2017年 lantaiyuan. All rights reserved.
//

#import "UIButton+SYDFixMultiClick.h"
#import <objc/runtime.h>
#define defaultInterval 1  //默认时间间隔
@interface UIButton ()

/**
 *  bool YES 忽略点击事件   NO 允许点击事件
 */
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end
@implementation UIButton (SYDFixMultiClick)
// 因category不能添加属性，只能通过关联对象的方式。
static const char *UIControl_eventTimeInterval = "UIControl_eventTimeInterval";
static const char *UIControl_enventIsIgnoreEvent = "UIControl_enventIsIgnoreEvent";

// runtime 动态绑定 属性
- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent
{
    objc_setAssociatedObject(self, UIControl_enventIsIgnoreEvent, @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, UIControl_enventIsIgnoreEvent) boolValue];
}

- (NSTimeInterval)eventTimeInterval
{
    return [objc_getAssociatedObject(self, UIControl_eventTimeInterval) doubleValue];
}

- (void)setEventTimeInterval:(NSTimeInterval)eventTimeInterval
{
    objc_setAssociatedObject(self, UIControl_eventTimeInterval, @(eventTimeInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
// 在load时执行hook
+ (void)load {
    // Method Swizzling
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selA = @selector(sendAction:to:forEvent:);
        SEL selB = @selector(_wxd_sendAction:to:forEvent:);
        Method methodA = class_getInstanceMethod(self,selA);
        Method methodB = class_getInstanceMethod(self, selB);
        
        BOOL isAdd = class_addMethod(self, selA, method_getImplementation(methodB), method_getTypeEncoding(methodB));
        
        if (isAdd) {
            class_replaceMethod(self, selB, method_getImplementation(methodA), method_getTypeEncoding(methodA));
        }else{
            //添加失败了 说明本类中有methodB的实现，此时只需要将methodA和methodB的IMP互换一下即可。
            method_exchangeImplementations(methodA, methodB);
        }
    });
}

- (void)_wxd_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    self.eventTimeInterval = self.eventTimeInterval == 0 ? defaultInterval : self.eventTimeInterval;
    if (self.isIgnoreEvent){
        return;
    }else if (self.eventTimeInterval > 0){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.eventTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setIsIgnoreEvent:NO];
        });
    }
    self.isIgnoreEvent = YES;
    // 这里看上去会陷入递归调用死循环，但在运行期此方法是和sendAction:to:forEvent:互换的，相当于执行sendAction:to:forEvent:方法，所以并不会陷入死循环。
    [self _wxd_sendAction:action to:target forEvent:event];
}

/**
 倒计时按钮
 
 @param duration 总时间
 @param runBlock 倒计时期间回调
 @param endBlock 倒计时结束回调
 */
-(void)startWithDuration:(NSInteger)duration running:(RunBlock)runBlock finishedBlock:(EndBlock)endBlock{
    
    __block NSInteger timeOut = duration;
    dispatch_queue_t queue    = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer  = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        if (timeOut <= 0) {
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                endBlock(self);
            });
        } else {
            
            int allTime = (int)duration + 1;
            int seconds = timeOut % allTime;
            dispatch_async(dispatch_get_main_queue(), ^{
                runBlock(self, duration, seconds);
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}
@end
