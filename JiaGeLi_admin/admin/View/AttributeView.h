//
//  AttributeCollectionView.h
//  PersonalTailor
//
//  Created by sandyrilla on 16/5/31.
//  Copyright © 2016年 com.Bluemobi. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ButtonModel : NSObject

@property (nonatomic, strong) UIColor *normalTitleColor;

@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIColor *normalBackgroundColor;

@property (nonatomic, strong) UIColor *selectedBackgroundColor;

@property (nonatomic, strong) UIColor *butBorderColor;
@property (nonatomic, assign) NSInteger  butBorderWidth;
@property (nonatomic, assign) NSInteger attributeViewY;
@end
@class AttributeView;

@protocol AttributeViewDelegate<NSObject>
@optional
-(void)Attribute_View:(AttributeView *)view didClickBtn:(UIButton *)btn;
@end

@interface AttributeView : UIView
@property(nonatomic,assign)id <AttributeViewDelegate>Attribute_delegate;

/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithButton:(ButtonModel *)model attributeTexts:(NSArray *)texts  viewWidth:(CGFloat)viewWidth;
@end
