
//
//  EditImageView.m
//  JiaGeLi_admin
//
//  Created by macbook on 2019/8/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditImageView.h"

@implementation EditImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self =[EditImageView editImageViewwWithOwnNib];
        [self.partImageSIV isShowAddBtn:YES];
        self.partImageSIV.isShowDelete = NO;
        self.partImageSIV.collectionView.scrollEnabled = YES;
        self.frame = frame;
        
    }
    
    return self;
}
+ (instancetype)editImageViewwWithOwnNib
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"EditImageView" owner:nil options:nil];
    return nibs.firstObject;
}

@end
