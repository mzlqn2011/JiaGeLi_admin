//
//  SaleHouseView.h
//  JiaGeLi
//
//  Created by LTY on 2019/8/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SaleHouseView : UIView
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *reservatBtn;
@property (weak, nonatomic) IBOutlet UIButton *onlineBtn;
- (instancetype)initWithFrame:(CGRect)frame;
+ (instancetype)saleHouseViewWithOwnNib;
@end

NS_ASSUME_NONNULL_END
