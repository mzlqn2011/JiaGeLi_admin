//
//  EidtHouseTableViewCell.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "EidtHouseTableViewCell.h"
#import "EditTFView.h"
@interface EidtHouseTableViewCell ()
@property(nonatomic,strong)NSMutableArray *attributeArray;
@end
@implementation EidtHouseTableViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if ((self = [super initWithFrame:frame])) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.attributeArray = @[@"满两年",@"电梯房",@"有车位",@"精装修"].mutableCopy;
    NSArray * titles = @[@[@"小区名称",@"门牌号",@"期望售价",@"户型",@"朝向",@"面积",@"楼层",@"房屋类型",@"产权"],@[@"满两年",@"电梯房",@"有车位",@"精装修"],@[@"开发商",@"绿化率",@"年代",@"容积率",@"建筑类型"],@[@"描述详情"],@[@"称呼",@"联系方式"]];
     NSArray * texts = @[@"基本信息",@"选择标签",@"小区信息",@"房源描述",@"个人信息"];
    NSArray * showPopArr = @[@"楼层"];
    __block CGFloat y = 0;
//    [titles enumerateObjectsUsingBlock:^(NSArray* arr, NSUInteger idx, BOOL * _Nonnull stop) {
        for (int idx = 0; idx<titles.count; idx++) {
            NSArray* arr = titles[idx];
            UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 10)];
            line.backgroundColor = UIColorFromRGB(0xF6F6F6);
            [self.contentView addSubview:line];
            y = CGRectGetMaxY(line.frame);
            UIView * v = [[UIView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 40)];
            v.backgroundColor = kWhiteColor;
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(18, 20, kScreenWidth -18, 20)];
            if(texts.count>idx){
               label.text = texts[idx];
            }
            label.font = font(16);
            label.textColor = k3GrayFontColor;
            [v addSubview:label];
            [self.contentView addSubview:v];
            y = CGRectGetMaxY(v.frame);
      if (idx == 1) {
         
          self.attributeV1.frame = CGRectMake(0, y, kScreenWidth, CGRectGetHeight(self.attributeV1.frame));
          [self.contentView addSubview:self.attributeV1];

            y = CGRectGetMaxY(self.attributeV1.frame);
           continue;
      }
        NSInteger tagIndex = 10*idx;
        for (int i = 0; i<arr.count; i++) {
            NSString * title = arr[i];
            EditTFView * v = [EditTFView editTFViewWithOwnNib];
            //            EditTFView * v = [[EditTFView alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 50)];
            v.title.text = title;
            v.textF.tag = tagIndex +i;
            v.showPopView = [showPopArr containsObject:title];
            [self.contentView addSubview:v];
            [self bundleTF:v.textF tag:v.textF.tag];
            [v mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentView.mas_top).offset(y);
                make.left.right.equalTo(self.contentView);
                make.height.equalTo(@50);
            }];
            y += 50;
        }
        
    }
//    ];
    [self channelRACTF];
}
- (AttributeView *)attributeV1{
    ButtonModel *model = [[ButtonModel alloc]init];
    model.normalTitleColor =k3GrayFontColor;
    model.selectedTitleColor =kWhiteColor;
    model.normalBackgroundColor =UIColorFromRGB(0xF6F6F6);
    model.selectedBackgroundColor =UIColorFromRGB(0x3BA8FF);
    model.attributeViewY = 0;
    _attributeV1 = [AttributeView  attributeViewWithButton:model attributeTexts:self.attributeArray viewWidth:kScreenWidth];
    return _attributeV1;
}

- (void)bundleTF:(UITextField *)tf tag:(NSInteger)tag{
    switch (tag) {
        case 0:
            self.xqmc = tf;
            break;
        case 1:
            self.mph = tf;
            break;
        case 2:
            self.qwsj = tf;
            break;
        case 3:
            self.hx = tf;
            break;
        case 4:
            self.cx = tf;
            break;
        case 5:
            self.mj = tf;
            break;
        case 6:
            self.lc = tf;
            break;
        case 7:
            self.fwlx = tf;
            break;
        case 8:
            self.cq = tf;
            break;
//        case 10:
//            self.nc = tf;
//            break;
//        case 11:
//            self.xb = tf;
//            break;
//        case 12:
//            self.sg = tf;
//            break;
//        case 13:
//            self.hyzk = tf;
//            break;
       
        case 20:
            self.kfs = tf;
            break;
        case 21:
            self.lhl = tf;
            break;
        case 22:
            self.nd = tf;
            break;
        case 23:
            self.rjl = tf;
            break;
        case 24:
            self.jzlx = tf;
            break;
        case 30:
            self.msxq = tf;
            break;
        case 40:
            self.ch = tf;
            break;
        case 41:
            self.lxfs = tf;
            break;
        default:
            break;
    }
    
}
- (void)channelRACTF{
    //    @[@[@"小区名称",@"门牌号",@"期望售价",@"户型",@"朝向",@"面积",@"楼层",@"房屋类型",@"产权"],@[@"满两年",@"电梯房",@"有车位",@"精装修"],@[@"开发商",@"绿化率",@"年代",@"容积率",@"建筑类型"],@[@"描述详情"],@[@"称呼",@"联系方式"]];
//    RACChannelTo(self.xqmc,text) = RACChannelTo(_applyerModel,occupation);
//    RACChannelTo(self.mph,text) = RACChannelTo(_applyerModel,salary);
//    RACChannelTo(self.qwsj,text) = RACChannelTo(_applyerModel,addr);
//    RACChannelTo(self.hx,text) = RACChannelTo(_applyerModel,nickname);
//    RACChannelTo(self.cx,text) = RACChannelTo(_applyerModel,sex);
//    RACChannelTo(self.mj,text) = RACChannelTo(_applyerModel,height);
//    RACChannelTo(self.lc,text) = RACChannelTo(_applyerModel,marriage_status);
//    RACChannelTo(self.fwlx,text) = RACChannelTo(_applyerModel,native_place);
//    RACChannelTo(self.cq,text) = RACChannelTo(_applyerModel,blood);
//    RACChannelTo(self.kfs,text) = RACChannelTo(_applyerModel,sx);
//    RACChannelTo(self.lhl,text) = RACChannelTo(_applyerModel,hobby);
//    RACChannelTo(self.nd,text) = RACChannelTo(_applyerModel,qualification);
//    RACChannelTo(self.rjl,text) = RACChannelTo(_applyerModel,birth);
//    RACChannelTo(self.jzlx,text) = RACChannelTo(_applyerModel,more_request);
//  RACChannelTo(self.msxq,text) = RACChannelTo(_applyerModel,more_request);
//  RACChannelTo(self.ch,text) = RACChannelTo(_applyerModel,more_request);
//  RACChannelTo(self.lxfs,text) = RACChannelTo(_applyerModel,more_request);
 
    
}
@end
