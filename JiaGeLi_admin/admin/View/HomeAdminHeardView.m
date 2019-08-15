//
//  HomeAdminHeardView.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HomeAdminHeardView.h"

@implementation HomeAdminHeardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self =[HomeAdminHeardView homeAdminHeardViewWithOwnNib];
        
        self.frame = frame;
        
    }
    
    return self;
}
+ (instancetype)homeAdminHeardViewWithOwnNib
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"HomeAdminHeardView" owner:nil options:nil];
    return nibs.firstObject;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    _icon.layer.cornerRadius = 3;
    
}
@end
