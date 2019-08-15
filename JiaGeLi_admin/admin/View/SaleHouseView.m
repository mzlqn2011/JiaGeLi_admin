//
//  SaleHouseView.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/5.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SaleHouseView.h"

@implementation SaleHouseView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self =[SaleHouseView saleHouseViewWithOwnNib];
        
        self.frame = frame;
        
    }
    
    return self;
}
+ (instancetype)saleHouseViewWithOwnNib
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"SaleHouseView" owner:nil options:nil];
    return nibs.firstObject;
}

@end
