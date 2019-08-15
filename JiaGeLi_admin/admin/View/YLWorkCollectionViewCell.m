//
//  YLWorkCollectionViewCell.m
//  ZGJEHome
//
//  Created by LTY on 2019/5/6.
//  Copyright © 2019年 lantaiyuan. All rights reserved.
//

#import "YLWorkCollectionViewCell.h"

@implementation YLWorkCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.titleLabel];

        
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(40);
            make.centerY.equalTo(self.contentView).offset(-10);
            make.centerX.equalTo(self.contentView);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.mas_equalTo(20);
        }];
        
       
    }
    return self;
}

//- (void)setBadgeString:(NSString*)number {
//    _badgeLabel.text = number;
//
//    if (number.integerValue > 0) {
//        _badgeLabel.hidden = NO;
//        _badgeLabel.adjustsFontSizeToFitWidth = YES;
//
//        CGSize sz = [_badgeLabel.text sizeWithFontSuper:_badgeLabel.font];
//        if (sz.width > _badgeLabel.width) {
//            _badgeLabel.width = sz.width;
//            [_badgeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.width.mas_equalTo(sz.width);
//            }];
//        }
//    }else {
//        _badgeLabel.hidden = YES;
//    }
//
//
//}

- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel*)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kGrayFontColor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = font(12);
    }
    return _titleLabel;
}


//- (void)setSubModel:(ServiceTypeInfoModel *)subModel{
//    self.imageView.image =  [UIImage imageNamed:subModel.image];
//    self.titleLabel.text = subModel.title;
//}

@end
