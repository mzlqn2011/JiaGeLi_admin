//
//  EidtHouseTableViewCell.h
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RACKVOChannel.h"
#import "SaleHouseModel.h"
#import "AttributeView.h"
NS_ASSUME_NONNULL_BEGIN

@interface EidtHouseTableViewCell : UITableViewCell
@property (weak, nonatomic) UITextField *bt;//标题
@property (weak, nonatomic) UITextField *xqdz;//小区地址
@property (weak, nonatomic) UITextField *mph;//门牌号
@property (weak, nonatomic) UITextField *qwsj;//期望售价
@property (weak, nonatomic) UITextField *sczp;//上传照片
@property (weak, nonatomic) UITextField *hx;//户型
@property (weak, nonatomic) UITextField *cx;//朝向
@property (weak, nonatomic) UITextField *mj;//面积
@property (weak, nonatomic) UITextField *lc;//楼层
@property (weak, nonatomic) UITextField *fwlx;//房屋类型
@property (weak, nonatomic) UITextField *cq;//产权
@property (weak, nonatomic) UITextField *kfs;//开发商
@property (weak, nonatomic) UITextField *lhl;//绿化率
@property (weak, nonatomic) UITextField *nd;//年代
@property (weak, nonatomic) UITextField *rjl;//容积率
@property (weak, nonatomic) UITextField *jzlx;//建筑类型
@property (weak, nonatomic) UITextField *msxq;//描述详情
@property (weak, nonatomic) UITextField *ch;//称呼
@property (weak, nonatomic) UITextField *lxfs;//联系方式
@property (strong, nonatomic) AttributeView *attributeV1;//
@end

NS_ASSUME_NONNULL_END
