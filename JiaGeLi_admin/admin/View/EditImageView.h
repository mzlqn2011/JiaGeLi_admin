//
//  EditImageView.h
//  JiaGeLi_admin
//
//  Created by macbook on 2019/8/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectImageV.h"
NS_ASSUME_NONNULL_BEGIN

@interface EditImageView : UIView
@property (weak, nonatomic) IBOutlet SelectImageV *partImageSIV;
- (instancetype)initWithFrame:(CGRect)frame;
+ (instancetype)editImageViewwWithOwnNib;
@end

NS_ASSUME_NONNULL_END
