//
//  EditHouseViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "EditHouseViewController.h"
#import "EidtHouseTableViewCell.h"
#import "ASIFormDataRequest.h"
#import "SaleHouseView.h"
#import "RMPickerView.h"
@interface EditHouseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong) UIButton * footerView;
@property (nonatomic,strong) SaleHouseView  * headView;
@property (nonatomic,strong) EidtHouseTableViewCell *cell;
@property(nonatomic,strong) NSMutableArray *photos;
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
-(NSMutableArray *)photos{
    if (!_photos) {
        _photos = [NSMutableArray arrayWithCapacity:7];
    }
    return _photos;
}
- (void)callClick{
    [self postAddHouseInfo];
}
#pragma mark ---- Delegate



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 1350;
}


#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.cell = [[EidtHouseTableViewCell  alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 1350)];
    //NSArray * showPopArr = @[@"月薪",@"性别",@"血型",@"属相",@"学历",@"生日"];
     NSMutableArray * temp = [[NSMutableArray alloc]init];
    self.cell.imageEditView.partImageSIV.currentCount = ^(NSInteger count) {
       self.cell.imageEditView.count.text = [NSString stringWithFormat:@"%lu/6张",(unsigned long) self.cell.imageEditView.partImageSIV.getPhotos.count];
        for (UIImage* img in [self.cell.imageEditView.partImageSIV getPhotos]) {
            if (![temp containsObject:img]) {
                [temp addObject:img];
                [self postImageUp:img];
            }
        }
    };
    self.cell.imageEditView.partImageSIV.presentVC = self;
    self.cell.imageEditView.partImageSIV.maxImagesCount = 6;
    [self.cell.imageEditView.partImageSIV isShowAddBtn:YES];
    self.cell.imageEditView.partImageSIV.isShowDelete = NO;
   self.cell.imageEditView.partImageSIV.collectionView.scrollEnabled = YES;
    
    self.cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return self.cell;
}
- (void)postImageUp:(UIImage *)image{
    NSString *action = [NSString stringWithFormat:@"%s%@", kServiceUrl, @"uploadPhoto"];
    NSString *uploadUrl = [NSString stringWithFormat:@"%@%@", RootUrl, action];
    NSData *iconData;
    iconData = UIImageJPEGRepresentation(image, 0.5);
    ASIFormDataRequest *request = [[ASIFormDataRequest alloc]initWithURL:[NSURL URLWithString:uploadUrl]];
    [request addPostValue:@"1" forKey:@"type"];//0婚姻，1房屋中介，2农产品，3家装产品，4卖家Logo
    [request addPostValue:@(image.size.width) forKey:@"width"];
    [request addPostValue:@(image.size.height) forKey:@"height"];
    
    request.delegate =self;
    request.requestMethod = @"POST";//设置请求方式
    
    //添加请求内容
    if (iconData) {
        [request addData:iconData withFileName:@"photo.png" andContentType:@"image/png" forKey:@"src[]"];
    }
    //
    //    if (self.isPosting) {
    //        return;
    //    }else{
    //        self.isPosting = YES;
    //    }
    //开始异步请求
    [request startAsynchronous];
}
#pragma mark - ASIFormDataRequest 代理
-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
    //    _isPosting = NO;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSLog(@"report result: %@", jsonDic);
    if (NetWork_Success) {
        [self.photos addObject:jsonDic[@"data"][@"src"]] ;
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD displayErrorWithStatus:jsonDic[NetWork_Msg]];
        });
        
    }
    //不明原因返回null，所以都会执行返回
    
}

-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSDictionary *userinfo = request.userInfo;
    [SVProgressHUD displayErrorWithStatus:@"操作失败，可能是网络原因"];
    
}
- (void)postAddHouseInfo
{
    NSString * photos = [self.photos componentsJoinedByString:@","];
    if(self.cell.bt.text.length == 0||self.cell.xqdz.text.length == 0||self.cell.mph.text.length == 0||self.cell.qwsj.text.length == 0||self.cell.xqmc.text.length == 0||self.cell.hx.text.length == 0||self.cell.cx.text.length == 0||self.cell.mj.text.length == 0||self.cell.lc.text.length == 0||self.cell.fwlx.text.length == 0||self.cell.cq.text.length == 0||self.cell.kfs.text.length == 0||self.cell.lhl.text.length == 0||self.cell.nd.text.length == 0||self.cell.rjl.text.length == 0||self.cell.jzlx.text.length == 0||self.cell.msxq.text.length == 0||self.cell.ch.text.length == 0||self.cell.lxfs.text.length == 0||photos.length == 0){
        [SVProgressHUD displayInfoWithStatus:@"请填写完整的卖房信息"];
        return;
    }
    NSString *action = [NSString stringWithFormat:@"%s%@", kServiceUrl, @"houseTradeAdd"];
    NSDictionary *paramDic = @{@"title":self.cell.bt.text,
                               @"village_name":self.cell.xqmc.text,
                               @"house_name":self.cell.mph.text,
                               @"photos":photos ,
                               @"pric":self.cell.qwsj.text,
                               @"type":self.cell.hx.text,
                               @"size":self.cell.mj.text,
                               @"direction":self.cell.cx.text,
                               @"floor":self.cell.lc.text,
                               @"house_type":self.cell.fwlx.text,
                               @"property":self.cell.cq.text,
                               @"developer":self.cell.kfs.text,
                               @"green_rate":self.cell.lhl.text,
                               @"building_type":self.cell.jzlx.text,
                               @"build_time":self.cell.nd.text,
                               @"size_rate":self.cell.rjl.text,
                               @"descri":self.cell.msxq.text,
                               @"name":self.cell.ch.text,
                               @"tel":self.cell.lxfs.text,
                               @"location":self.cell.xqdz.text,
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
