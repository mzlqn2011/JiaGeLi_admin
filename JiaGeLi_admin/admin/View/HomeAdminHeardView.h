//
//  HomeAdminHeardView.h
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeAdminHeardView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *todayAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UILabel *mouthAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalOrder;
@property (weak, nonatomic) IBOutlet UILabel *todayOrder;
+ (instancetype)homeAdminHeardViewWithOwnNib;
- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
