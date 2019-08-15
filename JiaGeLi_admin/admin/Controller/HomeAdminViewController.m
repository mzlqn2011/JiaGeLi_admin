//
//  HomeAdminViewController.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "HomeAdminViewController.h"
#import "YLWorkCollectionViewCell.h"
#import "HomeAdminHeardView.h"
@interface HomeAdminViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) HomeAdminHeardView * heardView;
@property (nonatomic, strong) UICollectionView * collectionView;

@end

@implementation HomeAdminViewController
{
    NSArray * imageNames;
    NSArray * titles;
    NSArray * controllerNames;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"店铺管理";
    [self setcontentView];
}
- (void)initData{
    
    titles = @[@"发布商品",@"商品管理",@"订单管理",@"评论管理",@"房屋中介"];
    imageNames = @[@"89",@"96",@"97",@"98",@"114"];
    controllerNames = @[@"",@"",@"MineSettingViewController",@"FeedBackViewController",@"AboutUSViewController"];
    
}
-(void)setcontentView{

    self.view.backgroundColor =       UIColorFromRGB(0xFFFFFF);
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerClass:[YLWorkCollectionViewCell class] forCellWithReuseIdentifier:@"YLWorkCollectionViewCell"];
    [self.collectionView registerClass:[HomeAdminHeardView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeAdminHeardView"];
    
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
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}

#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    HomeAdminHeardView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HomeAdminHeardView" forIndexPath:indexPath];
   
    if (titles.count > indexPath.section)
    {
        
//        YLRoleMenusModel *model  =  self.dataSource[indexPath.section];
//        headerView.foldButton.hidden = model.showFoldButton;
//        headerView.foldButton.selected = model.apps.count<5;
//        headerView.model = model;
        
       
    }
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
        cell.titleLabel.text = titles[indexPath.row];;
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
        _collectionView =  [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationHeight , kScreenWidth, kScreenWidth - kNavigationHeight) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.bounces = NO;
        _collectionView.userInteractionEnabled = YES;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}
@end
