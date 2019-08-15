//
//  UIView+Extension.h
//  JiLaiBao
//
//  Created by youmy on 15/8/14.
//  Copyright (c) 2015年 youmy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^TRGestureActionBlock)(UIGestureRecognizer *trGestureRecoginzer);

@interface UIView (Extension)
/** x坐标 */
@property (nonatomic, assign) CGFloat x;
/** y坐标 */
@property (nonatomic, assign) CGFloat y;
/** 中心x坐标 */
@property (nonatomic, assign) CGFloat centerX;
/** 中心y坐标 */
@property (nonatomic, assign) CGFloat centerY;
/** 宽度 */
@property (nonatomic, assign) CGFloat width;
/** 高度 */
@property (nonatomic, assign) CGFloat height;
/** 大小 */
@property (nonatomic, assign) CGSize size;
/** 原点 */
@property (nonatomic, assign) CGPoint origin;

/** 绘制边框 */
- (void)drawBorder;

/** 绘制边框+颜色 */
- (void)drawBorderWithColor:(UIColor *)color;

/** 绘制边框+颜色+线条宽度 */
- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width;

/** 绘制边框+圆弧 */
- (void)drawBorderWithCornerRadius:(CGFloat)radius;

/** 绘制边框+颜色+圆弧 */
- (void)drawBorderWithColor:(UIColor *)color radius:(CGFloat)radius;

/** 绘制边框+颜色+边框宽度+圆弧 */
- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width radius:(CGFloat)radius;

/** 添加阴影 */
- (void)addShadow;

- (void)addBottomShadow:(UIColor *)color;

- (void)drawLineImageWithRect:(CGRect)rect;

/**
 *  画线
 *
 *  @param color 线条颜色
 *  @param rect  线条frame
 */
- (void)drawLineWithColor:(UIColor *)color rect:(CGRect)rect;
// 画虚线
- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
- (void)addTopLineWithColor:(UIColor *)color;
- (void)addTopLineWithColor:(UIColor *)color width:(CGFloat)width;
- (void)addBottomLineWithColor:(UIColor *)color;
- (void)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height;
- (void)addLeftLineWithColor:(UIColor *)color;
- (void)addRightLineWithColor:(UIColor *)color;
- (void)addRightLineWithColor:(UIColor *)color width:(CGFloat)width;
- (void)addCenterYLineWithColor:(UIColor *)color;
/** 隐藏键盘 */
- (void)hideKeyboard;

/** 获取所以变量 */
- (void)allIvar;

/** 获取所有属性 */
- (void)allProperty;

-(UIView *)getFirstResponder;

//自定义表头
+(UIView *)sectionHeader;

-(void)addBottomBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addLeftBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addRightBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;
-(void)addTopBorderWithColor: (UIColor *) color andWidth:(CGFloat) borderWidth;

- (void)trmAddTapActionWithBlock:(TRGestureActionBlock)block;
@end
