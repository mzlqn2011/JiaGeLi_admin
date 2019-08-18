//
//  SelectImageV.h
//  ZuoGongJiao
//
//  Created by LTY on 2018/11/9.
//  Copyright © 2018年 sandyrilla. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^photosCount)(NSInteger count);
@interface SelectImageV : UIView
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, weak) UIViewController *presentVC;
@property(nonatomic) NSInteger maxImagesCount;/**< 图片显示最大数量 */
@property(nonatomic) BOOL isShowDelete;/**< 是否显示图片删除按钮 */
@property(nonatomic) BOOL isShowRoundImage;/**< 是否以圆形显示图片(目前是仅在显示网络图片时展示次效果) */
@property (nonatomic, copy) photosCount currentCount;
@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSMutableArray *picGuidIDs;
@property(nonatomic, assign)CGSize imageSize;
- (void)loadWebImages:(NSArray *)webImagesArr;/**< 初次进入显示网络图片 */
- (NSMutableArray *)getPhotos;
- (void)isShowAddBtn:(BOOL)isShow;

@end


