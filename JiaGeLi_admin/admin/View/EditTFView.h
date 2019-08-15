//
//  EditTFView.h
//  JiaGeLi
//
//  Created by LTY on 2019/8/6.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EditTFView : UIView
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UITextField *textF;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (assign, nonatomic)BOOL showPopView;
- (void)setShowPopView:(BOOL)showPopView;
+ (instancetype)editTFViewWithOwnNib;
- (instancetype)initWithFrame:(CGRect)frame;
@end

NS_ASSUME_NONNULL_END
