//
//  EditTFView.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import "EditTFView.h"

@implementation EditTFView
- (void)setShowPopView:(BOOL)showPopView{
    _showPopView = showPopView;
    if (_showPopView) {
        [_textF resignFirstResponder];
        _arrowBtn.hidden = NO;
    }
   
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self =[EditTFView editTFViewWithOwnNib];
        
        self.frame = frame;
        
    }
    
    return self;
}
+ (instancetype)editTFViewWithOwnNib
{
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"EditTFView" owner:nil options:nil];
    return nibs.firstObject;
}
@end
