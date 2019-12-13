//
//  DistributeGoodsVC.h
//  JiaGeLi
//
//  Created by mac on 2019/12/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DistributeGoodsVC : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *imgArea;
@property (weak, nonatomic) IBOutlet UIView *detailArea;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *originPriceTF;
@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextView *describeTV;
@property (weak, nonatomic) IBOutlet UISwitch *recommendSW;

@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

NS_ASSUME_NONNULL_END
