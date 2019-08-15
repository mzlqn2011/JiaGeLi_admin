//
//  YLWorkCollectionViewCell.h
//  ZGJEHome
//
//  Created by LTY on 2019/5/6.
//  Copyright © 2019年 lantaiyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YLWorkCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *badgeLabel;


- (void)setBadgeString:(NSString*)number;
@end

NS_ASSUME_NONNULL_END
