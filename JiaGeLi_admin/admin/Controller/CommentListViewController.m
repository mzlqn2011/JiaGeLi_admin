
//
//  CommentListViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentTableViewCell.h"
#import "SHJPagesModel.h"
@interface CommentListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,strong) UILabel *count;
@property (nonatomic,assign) NSInteger totalCount;
@property (nonatomic, strong) SHJPagesModel *pageModel;
@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评价管理";
     [self setcontentView];
}
-(void)setcontentView{
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentTableViewCell"];
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.pageModel.page = 1;
        [self.dataSource removeAllObjects];
        [self loadListData];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageModel.page += 1;
        [self loadListData];
    }];
}
- (void)refreshTableView {
    self.pageModel.page = 1;
    [self.dataSource removeAllObjects];
    [self.tableView reloadData];
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView =  [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight , kScreenWidth, kScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = kGrayBgColor;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    return _tableView;
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (SHJPagesModel *)pageModel {
    if (_pageModel == nil) {
        _pageModel = [[SHJPagesModel alloc] init];
        _pageModel.page = 1;
        _pageModel.page = 10;
    }
    return _pageModel;
}
#pragma mark ---- Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

#pragma mark UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataSource.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentTableViewCell"];
    if (_dataSource.count> indexPath.row) {
//        cell.model = _dataSource[indexPath.row];;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 41;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * v =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    UILabel * b = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    b.text = @"全部评价";
    [v addSubview:b];
    self.count = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 80, 20)];
    self.count.text = [NSString stringWithFormat:@"(%ld条)",(long)self.totalCount];
    [v addSubview:b];
    return v;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

- (void)loadListData
{
    NSString *action = [NSString stringWithFormat:@"%s%@", kUserUrl, @"commentList"];
    NSDictionary *paramDic = @{@"seller_id":JGLSingle.userModel.seller_id,@"auth_token":JGLSingle.userModel.auth_token,@"page":@(self.pageModel.page),@"page":@(self.pageModel.rows)};
    
    [kDataRequestManager POST2RequestWithUrl:action parameters:paramDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        if (NetData_Eexist) {
             NSArray *dataArr = [Common getDicArrayFromArrayDic:jsonDic[NetWork_Data]];
            if (dataArr.count == 0) {
                if (self.dataSource.count == 0) {
//                    self.tableView.tableFooterView = self.footerView;
                }
                else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }
            }else {
                [self.dataSource addObjectsFromArray:dataArr];
               
            }
        }
        [self.tableView reloadData];
    } failed:^(NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
    
}
@end
