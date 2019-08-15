//
//  EditHouseViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "EditHouseViewController.h"
#import "EidtHouseTableViewCell.h"
#import "SaleHouseView.h"
#import "RMPickerView.h"
@interface EditHouseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong) UIButton * footerView;
@property (nonatomic,strong) SaleHouseView  * headView;
@property (nonatomic,strong) EidtHouseTableViewCell *cell;
@end

@implementation EditHouseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我要卖房";
     [self setcontentView];
}

-(void)setcontentView{
    
    [self.view addSubview:self.tableView];
    
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight , kScreenWidth, kScreenHeight - kNavigationHeight ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor =  UIColorFromRGB(0xF6F6F6);
        _headView = [[SaleHouseView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 160)];
        _tableView.tableHeaderView = _headView;
        _tableView.tableFooterView = self.footerView;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _tableView;
}
- (UIButton *)footerView{
    if (!_footerView) {
        
        UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        commitBtn.backgroundColor = kThemeColor;
        commitBtn.frame = CGRectMake(0, 0, kScreenWidth, 50);
        commitBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [commitBtn setTitleColor: [UIColor whiteColor] forState:UIControlStateNormal];
        [commitBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [commitBtn addTarget:self action:@selector(callClick) forControlEvents:UIControlEventTouchUpInside];
        _footerView = commitBtn;
    }
    return _footerView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (void)callClick{
    [self postAddHouseInfo];
}
#pragma mark ---- Delegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 836;
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [[EidtHouseTableViewCell  alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 836)];
    //NSArray * showPopArr = @[@"月薪",@"性别",@"血型",@"属相",@"学历",@"生日"];
    [self.cell.lc jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        RMPickerView * pickerV = [RMPickerView pickerWithOwnNib];
//        pickerV.pickerArray =  self.model.salaryArray;
        kWeakSelf
        pickerV.doneBlock =  ^(NSString * str, NSUInteger index){
            
            wSelf.cell.lc.text = str;
            
            return YES;
        };
        [pickerV show];
    }];
   
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.cell;
}
- (void)postAddHouseInfo
{
    if(self.cell.xqmc.text.length == 0||self.cell.mph.text.length == 0||self.cell.qwsj.text.length == 0||self.cell.hx.text.length == 0||self.cell.cx.text.length == 0||self.cell.mj.text.length == 0||self.cell.lc.text.length == 0||self.cell.fwlx.text.length == 0||self.cell.cq.text.length == 0||self.cell.kfs.text.length == 0||self.cell.lhl.text.length == 0||self.cell.nd.text.length == 0||self.cell.rjl.text.length == 0||self.cell.jzlx.text.length == 0||self.cell.msxq.text.length == 0||self.cell.ch.text.length == 0||self.cell.lxfs.text.length == 0){
        [SVProgressHUD displayInfoWithStatus:@"请填写完整的卖房信息"];
        return;
    }
    NSString *action = [NSString stringWithFormat:@"%s%@", kServiceUrl, @"houseTradeAdd"];
    NSDictionary *paramDic = @{@"user_id":JGLSingle.userModel.seller_id,
                               @"name":JGLSingle.userModel.auth_token,
                               @"birth":JGLSingle.userModel.auth_token,
                               @"sex":JGLSingle.userModel.auth_token,
                               @"height":JGLSingle.userModel.auth_token,
                               @"qualification":JGLSingle.userModel.auth_token,
                               @"salary":JGLSingle.userModel.auth_token,
                               @"hobby":JGLSingle.userModel.auth_token,
                               @"sx":JGLSingle.userModel.auth_token,
                               @"constellation":JGLSingle.userModel.auth_token,
                               @"marriage_status":JGLSingle.userModel.auth_token,
                               @"tel":JGLSingle.userModel.auth_token,
                               @"occupation":JGLSingle.userModel.auth_token,
                               @"addr":JGLSingle.userModel.auth_token,
                               @"native_place":JGLSingle.userModel.auth_token,
                               @"blood":JGLSingle.userModel.auth_token,
                               @"more_request":JGLSingle.userModel.auth_token,
                               @"head_photo":JGLSingle.userModel.auth_token,
                               @"photos":JGLSingle.userModel.auth_token,
                               };
    
    [kDataRequestManager POST2RequestWithUrl:action parameters:paramDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
            [SVProgressHUD displaySuccessWithStatus:@"提交信息成功！"];
            [self .navigationController popViewControllerAnimated:YES];
        }
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
}
@end
