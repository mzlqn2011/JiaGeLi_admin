//
//  HomeAdminViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HomeAdminViewController.h"
#import "YLWorkCollectionViewCell.h"
#import "CommentListViewController.h"
#import "EditHouseViewController.h"
#import "TiXianViewController.h"
#import "HomeAdminHeardView.h"
@interface HomeAdminViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
//@property (nonatomic, weak) HomeAdminHeardView * heardAdminView;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation HomeAdminViewController
{
    NSArray * imageNames;
    NSArray * titles;
    NSArray * controllerNames;
    NSString * day_income;
    NSString * total_income;
    NSString * month_income;
    NSString * week_income;
    NSString * order_count;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"店铺管理";
    [self initData];
    [self setcontentView];
    [self requestIncomeData];
}

- (void)initData
{
    titles = @[@"发布商品",@"商品管理",@"订单管理",@"评论管理",@"房屋中介"];

    imageNames = @[@"l_product_add",@"l_product_manage",@"l_order",@"l_comment",@"l_house"];

    controllerNames = @[@"DistributeGoodsVC",@"GoodsManageVC",@"OrderManageVC",@"CommentListViewController",@"EditHouseViewController"];
    
}

-(void)setcontentView
{
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[YLWorkCollectionViewCell class] forCellWithReuseIdentifier:@"YLWorkCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeAdminHeardView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeAdminHeardView"];
    
}
#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger count = 4;
    return CGSizeMake(kScreenWidth / count, 85);
}

// 定义每个section的margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 每个item之间的距离
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//每个section中不同行的行间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - UICollectionViewDelegate
// 定义展示的Section的个数

// 定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return titles.count;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 240);
}

#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    HomeAdminHeardView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeAdminHeardView" forIndexPath:indexPath];
    NSString * imgs = [NSString stringWithFormat:@"%@%@",ImgRootUrl,JGLSingle.userModel.logo];
    [headerView.icon sd_setImageWithURL:[NSURL URLWithString:imgs] placeholderImage:[UIImage imageNamed:@"defult"]];
    [headerView.tixianButton jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        TiXianViewController * vc = [[TiXianViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    headerView.title.text = TR_securityString(JGLSingle.userModel.company_name);
    headerView.todayAmount.text =TR_securityString(day_income);
    headerView.totalAmount.text =TR_securityString(total_income);
    headerView.mouthAmount.text =TR_securityString(month_income);
    headerView.totalOrder.text =TR_securityString(week_income);
    headerView.todayOrder.text =TR_securityString(order_count);
    
 
    return headerView;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    return YES;
}

// 返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    YLWorkCollectionViewCell *cell ;
    if(cell){
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YLWorkCollectionViewCell" forIndexPath:indexPath];
    if (titles.count > indexPath.row)
    {
        cell.imageView.image = [UIImage imageNamed:imageNames[indexPath.row]];
        cell.titleLabel.text = titles[indexPath.row];
    }
    return cell;
}

// UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{	
  if (controllerNames.count>indexPath.row) {
      Class class = NSClassFromString(controllerNames[indexPath.row]);
      
      id vc = [[class alloc] init];
      [self.navigationController pushViewController:vc animated:YES];
  }
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _collectionView =  [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight , kScreenWidth, kScreenHeight - kNavigationHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.userInteractionEnabled = YES;
        _collectionView.backgroundColor = kGrayBgColor;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (void)requestIncomeData
{
    NSString *action = [NSString stringWithFormat:@"%s%@", kUserUrl, @"income"];
    NSDictionary *paramDic = @{@"seller_id":JGLSingle.userModel.seller_id,@"auth_token":JGLSingle.userModel.auth_token};
    
    [kDataRequestManager POST2RequestWithUrl:action parameters:paramDic success:^(id  _Nonnull jsonDic, NSInteger statusCode) {
        if (NetWork_Success) {
            self->day_income = [NSString stringWithFormat:@"%d",[jsonDic[@"data"][@"day_income"] intValue]];;
            self->total_income = [NSString stringWithFormat:@"%d",[jsonDic[@"data"][@"total_income"] intValue]];;
            self->month_income = [NSString stringWithFormat:@"%d",[jsonDic[@"data"][@"month_income"] intValue]];;
            self->week_income = [NSString stringWithFormat:@"%d",[jsonDic[@"data"][@"week_income"] intValue]];;
            self->order_count = [NSString stringWithFormat:@"%d",[jsonDic[@"data"][@"order_count"] intValue]];;
            [self.collectionView reloadData];
        }
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
}

@end
