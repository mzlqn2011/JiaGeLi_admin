//
//  AttributeCollectionView.m
//  PersonalTailor
//
//  Created by sandyrilla on 16/5/31.
//  Copyright © 2016年 com.Bluemobi. All rights reserved.
//


#import "AttributeView.h"
#import "UIView+Extension.h"
#define AppColor  Color(245, 58, 64)

#define margin 15
// 屏幕的宽
#define JPScreenW [UIScreen mainScreen].bounds.size.width
// 屏幕的高
#define JPScreenH [UIScreen mainScreen].bounds.size.height
//RGB
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation ButtonModel
- (instancetype)init{
    if (self = [super init]) {
        _normalTitleColor = [UIColor whiteColor];
        _selectedTitleColor = [UIColor whiteColor];
        _normalBackgroundColor= [UIColor whiteColor];
        _selectedBackgroundColor= [UIColor whiteColor];
         _butBorderColor = [UIColor whiteColor];
        _butBorderWidth= 1;
        _attributeViewY= 0;
    }
    return self;
}
@end
@interface AttributeView ()

@property (nonatomic ,strong) NSMutableArray *buttonArray;
@end

@implementation AttributeView
- (instancetype)initWithTitle:(NSString *)title titleFont:(UIFont *)font attributeTexts:(NSArray *)texts viewWidth:(CGFloat)viewWidth{
    int count = 0;
    float btnW = 0;
    float btnY = 0;
    AttributeView *view = [[AttributeView alloc]init];
    NSMutableArray *buttonArray = @[].mutableCopy;
    view.backgroundColor = [UIColor whiteColor];
    
    if(title){
         UILabel *label = [[UILabel alloc]init];
        label.text = [NSString stringWithFormat:@"%@ ",title];
        label.font = font;
        label.textColor = kGrayFontColor ;
        CGSize size = [label.text sizeWithFont:font];
        label.frame = (CGRect){{10,10},size};
        [view addSubview:label];
        btnY =label.height;
    }
   
    for (int i = 0; i<texts.count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:14]];
        
        btn.width = strsize.width + margin;
        btn.height = strsize.height+ margin;
        
        
        if (i == 0) {
            btn.x = margin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btn.x = margin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.x += btnW - btn.width;
                
            }
        }
        
        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn jk_setBackgroundColor:kGrayFontColor forState:UIControlStateNormal];
//        [btn jk_setBackgroundColor:GREEN_COLOR forState:UIControlStateSelected];
        
        btn.y += count * (btn.height + margin) + margin + btnY +8;
        
        btn.layer.cornerRadius = btn.height/2;
        btn.clipsToBounds = YES;
        
        btn.tag = i;
        [buttonArray addObject:btn];
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.height = CGRectGetMaxY(btn.frame) + 10;
            view.x = 0;
            view.width = viewWidth;
        }
    }
    
    return view;
}
/**
 *  返回一个创建好的属性视图,并且带有标题.创建好之后必须设置视图的Y值.
 *
 *  @param texts 属性数组
 *
 *  @param viewWidth 视图宽度
 *
 *  @return attributeView
 */
+ (AttributeView *)attributeViewWithButton:(ButtonModel *)model attributeTexts:(NSArray *)texts  viewWidth:(CGFloat)viewWidth{
    int count = 0;
    float btnW = 0;
    AttributeView *view = [[AttributeView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    if (!texts) {
        return view;
    }
    for (int i = 0; i<texts.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitleColor:model.normalTitleColor forState:UIControlStateNormal];
        [btn setTitleColor:model.selectedTitleColor forState:UIControlStateSelected];
        [btn jk_setBackgroundColor:model.normalBackgroundColor forState:UIControlStateNormal];
        [btn jk_setBackgroundColor:model.selectedBackgroundColor forState:UIControlStateSelected];
        btn.layer.borderWidth = model.butBorderWidth;
        btn.layer.borderColor = model.butBorderColor.CGColor;
        btn.tag = i;
        [btn addTarget:view action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        NSString *str = texts[i];
        [btn setTitle:str forState:UIControlStateNormal];
        CGSize strsize = [str sizeWithFont:[UIFont boldSystemFontOfSize:14]];
        
        btn.width = strsize.width + margin;
        btn.height = strsize.height+ margin;
        
        
        if (i == 0) {
            btn.x = margin;
            btnW += CGRectGetMaxX(btn.frame);
        }
        else{
            btnW += CGRectGetMaxX(btn.frame)+margin;
            if (btnW > viewWidth) {
                count++;
                btn.x = margin;
                btnW = CGRectGetMaxX(btn.frame);
            }
            else{
                
                btn.x += btnW - btn.width;
                
            }
        }

        btn.userInteractionEnabled = YES;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;

       
        btn.y += count * (btn.height + margin) + margin +model.attributeViewY +8;
        
        btn.layer.cornerRadius = btn.height/2;
        btn.clipsToBounds = YES;

        btn.tag = i;
        [view addSubview:btn];
        if (i == texts.count - 1) {
            view.height = CGRectGetMaxY(btn.frame) + 10;
            view.x = 0;
            view.width = viewWidth;
        }
    }
 
    return view;
}

- (void)btnClick:(UIButton *)sender{

     sender.selected = !sender.selected;
  
    if ([self.Attribute_delegate respondsToSelector:@selector(Attribute_View:didClickBtn:)] ) {
        [self.Attribute_delegate Attribute_View:self didClickBtn:sender];
    }

}

@end
