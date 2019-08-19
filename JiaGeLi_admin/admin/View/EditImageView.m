
//
//  EditImageView.m
//  JiaGeLi_admin
//
//  Created by macbook on 2019/8/18.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EditImageView.h"

@implementation EditImageView
- (void)awakeFromNib{
    [super awakeFromNib];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self =[EditImageView editImageViewwWithOwnNib];
        
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
