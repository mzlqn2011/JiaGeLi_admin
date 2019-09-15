//
//  DistributeGoodsVC.m
//  JiaGeLi_admin
//
//  Created by mac on 2019/8/16.
//  Copyright © 2019 mac. All rights reserved.
//

#import "DistributeGoodsVC.h"

@interface DistributeGoodsVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tabView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation DistributeGoodsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataArray = @[@"名称", @"类目", @"原价", @"现价", @"规格", @"描述"].mutableCopy;
    [self initView];
    
}

- (void)initView
{
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tabView.delegate = self;
    _tabView.dataSource = self;
    [self.view addSubview:_tabView];
    
    CGFloat btnHeight = kRealValue(50);
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(0, kScreenHeight - btnHeight, kScreenWidth, btnHeight);
    saveBtn.backgroundColor = UIColorFromRGB(0x99cc33);
    [saveBtn setTitle:@"保存发布" forState:kStateNormal];
    [saveBtn setTitleColor:kWhiteColor forState:kStateNormal];
    [self.view addSubview:saveBtn];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:kControlEventTouchUpInside];
}

- (void)saveBtnClick
{
    
}

#pragma mark - tabView delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRealValue(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}


@end
