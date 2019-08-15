//
//  UIView+Extension.m
//  JiLaiBao
//
//  Created by youmy on 15/8/14.
//  Copyright (c) 2015年 youmy. All rights reserved.
//
static char kActionHandlerTapBlockKey;
#import "UIView+Extension.h"

CGFloat line_height = 0.35;

@implementation UIView (Extension)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (CGFloat)centerX{
    CGPoint center = self.center;
    return center.x;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY{
    CGPoint center = self.center;
    return center.y;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)drawBorder{
    self.layer.borderColor = [UIColor colorWithWhite:0.7 alpha:0.5].CGColor;
    self.layer.borderWidth = line_height;
}

- (void)drawBorderWithColor:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = line_height;
}

- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)drawBorderWithCornerRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)drawBorderWithColor:(UIColor *)color radius:(CGFloat)radius{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = line_height;
    self.layer.cornerRadius = radius;
}

- (void)drawBorderWithColor:(UIColor *)color borderWidth:(CGFloat)width radius:(CGFloat)radius{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
    self.layer.cornerRadius = radius;
}

- (void)addShadow{
    self.layer.shadowColor = [UIColor redColor].CGColor;
    //    if (view == _SGUserView) {
    //        view.layer.shadowOffset = CGSizeMake(0, 0);
    //        view.layer.shadowOpacity = 0.7f;
    //        view.layer.shadowRadius = line_heightf;
    //        return;
    //    }
    self.layer.shadowOffset = CGSizeMake(10, 1);
    self.layer.shadowOpacity = 2;
    self.layer.shadowRadius = 2;
}

- (void)addBottomShadow:(UIColor *)color{
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 5.0;
}

- (void)drawLineImageWithRect:(CGRect)rect{
    UIImageView * line = [[UIImageView alloc] initWithFrame:rect];
    line.image = [UIImage imageNamed:@"separator"];
    [self addSubview:line];
}

/** 画线 */
- (void)drawLineWithColor:(UIColor *)color rect:(CGRect)rect{
    CALayer * lineLayer = [CALayer layer];
    lineLayer.backgroundColor = color.CGColor;
    lineLayer.frame = rect;
    [self.layer addSublayer:lineLayer];
}

- (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

- (void)addTopLineWithColor:(UIColor *)color{
    [self drawLineWithColor:color rect:CGRectMake(0, 0, self.width, line_height)];
}

- (void)addTopLineWithColor:(UIColor *)color width:(CGFloat)width{
    [self drawLineWithColor:color rect:CGRectMake(0, 0, width, line_height)];
}

- (void)addBottomLineWithColor:(UIColor *)color{
    [self drawLineWithColor:color rect:CGRectMake(0, self.height - line_height, self.width, line_height)];
}
- (void)addCenterYLineWithColor:(UIColor *)color{
    [self drawLineWithColor:color rect:CGRectMake(15, self.centerY, self.width - 30, line_height)];
}
- (void)addBottomLineWithColor:(UIColor *)color height:(CGFloat)height{
    [self drawLineWithColor:color rect:CGRectMake(0, self.height - height, self.width, height)];
}

- (void)addLeftLineWithColor:(UIColor *)color{
    [self drawLineWithColor:color rect:CGRectMake(0, 0, line_height, self.height)];
}

- (void)addRightLineWithColor:(UIColor *)color{
    [self drawLineWithColor:color rect:CGRectMake(self.width - line_height, 0, line_height, self.height)];
}

- (void)addRightLineWithColor:(UIColor *)color width:(CGFloat)width{
    [self drawLineWithColor:color rect:CGRectMake(self.width - width, 0, width, self.height)];
}

- (void)hideKeyboard{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
}

- (void)allIvar{
    uint outCount;
    
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"---Ivar-->%@",[NSString stringWithUTF8String:ivar_getName(ivar)]);
    }
}

- (void)allProperty{
    unsigned int outCount;
    int i;
    objc_property_t * pProperty = class_copyPropertyList([self class], &outCount);
    for (i = outCount - 1; i >= 0; i--) {
        NSString * propertyName = [NSString stringWithCString:property_getName(pProperty[i]) encoding:NSUTF8StringEncoding];
        NSString * getPropertyNameString = [NSString stringWithCString:property_getAttributes(pProperty[i]) encoding:NSUTF8StringEncoding];
        NSLog(@"---Property---%@--->%@",getPropertyNameString,propertyName);
    }
}
- (UIView *) getFirstResponder
{
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subView in self.subviews) {
        UIView *firstResponder = [subView getFirstResponder];
        if (firstResponder != nil) {
            return firstResponder;
        }
    }
    
    return nil;
}

+(UIView *)sectionHeader{
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    view.backgroundColor = kGrayBgColor;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, kScreenWidth - 15, view.height)];
    label.text = @"支付方式";
    label.textColor = kGrayFontColor;
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    return view;
}

-(void)addTopBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, self.frame.size.width, borderWidth); [self.layer addSublayer:border];
}
-(void)addBottomBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, borderWidth);
    [self.layer addSublayer:border];
}
-(void)addLeftBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(0, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
    
}
-(void)addRightBorderWithColor:(UIColor *)color andWidth:(CGFloat) borderWidth {
    CALayer *border = [CALayer layer];
    border.backgroundColor = color.CGColor;
    border.frame = CGRectMake(self.frame.size.width - borderWidth, 0, borderWidth, self.frame.size.height);
    [self.layer addSublayer:border];
}

- (void)trmAddTapActionWithBlock:(TRGestureActionBlock)block
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
    [self addGestureRecognizer:gesture];
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        TRGestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) block(gesture);
    }
}
@end
