//
//  SelectImageV.m
//  ZuoGongJiao
//
//  Created by LTY on 2018/11/9.
//  Copyright © 2018年 sandyrilla. All rights reserved.
//

#import "SelectImageV.h"
#import "TZImagePickerController.h"
#import "LxGridViewFlowLayout.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "TZVideoPlayerController.h"
#import "TZPhotoPreviewController.h"
#import "TZGifPhotoPreviewController.h"
#import "UIImageView+WebCache.h"
#import "MWPhotoBrowser.h"

@interface SelectImageV ()<UICollectionViewDataSource, UICollectionViewDelegate, LxGridViewDataSource, TZImagePickerControllerDelegate, MWPhotoBrowserDelegate>
{
    NSMutableArray *_headSelectedPhotos;
    NSMutableArray *_headSelectedAssets;
    BOOL _isSelectOriginalPhoto;
    
    CGFloat _margin;
    NSMutableArray *webImages;
    NSMutableArray *photos;
    BOOL isShowWebImage;
    BOOL isShowAddBtn;
}
@property(nonatomic, strong) UIImagePickerController *imagePickerVc;


@end

@implementation SelectImageV

@synthesize maxImagesCount;
@synthesize isShowDelete;
@synthesize picGuidIDs;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initView];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initView];
}

-(void)initView
{
    LxGridViewFlowLayout *layout = [[LxGridViewFlowLayout alloc] init];
    _margin = 4;
    layout.itemSize = CGSizeMake(kImageSize, kImageSize);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.tz_width, self.height) collectionViewLayout:layout];
    _collectionView.alwaysBounceVertical = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
    webImages = [[NSMutableArray alloc] init];
    photos = [[NSMutableArray alloc] init];
    picGuidIDs = [[NSMutableArray alloc] init];
    if(webImages.count < 1)
    {
        isShowWebImage = false;
    }
    else
    {
        isShowWebImage = true;
    }
    isShowDelete = YES;
    isShowAddBtn = YES;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(isShowWebImage)
    {
        return webImages.count + 1;
    }
    else
    {
        return _headSelectedPhotos.count + 1;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kImageSize, kImageSize);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if(isShowWebImage)
    {
        if (indexPath.row == webImages.count)
        {
            if(isShowAddBtn)
            {
                cell.imageView.hidden = NO;
                cell.imageView.image = [UIImage imageNamed:@"image_upload_picture.png"];
            }
            else
            {
                cell.imageView.hidden = YES;
            }
            cell.deleteBtn.hidden = YES;
            cell.gifLable.hidden = YES;
        }
        else
        {
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[webImages objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"icon_load_fail"]];
            if(_isShowRoundImage)
            {
                // 图片做圆形，圆角角度为高度的一半，而高宽一致，因此可以形成正圆
                cell.imageView.layer.masksToBounds = YES;
                cell.imageView.layer.cornerRadius = cell.imageView.frame.size.height / 2;
            }
            else
            {
                cell.imageView.layer.masksToBounds = NO;
                cell.imageView.layer.cornerRadius = 0;
            }
            cell.deleteBtn.hidden = YES;
            cell.gifLable.hidden = YES;
        }
    }
    else
    {
        if (indexPath.row == _headSelectedPhotos.count)
        {
            if(isShowAddBtn)
            {
                cell.imageView.hidden = NO;
                cell.imageView.image = [UIImage imageNamed:@"image_upload_picture.png"];
            }
            if (_headSelectedPhotos.count ==self.maxImagesCount) {
                 cell.imageView.hidden = YES;
            }
           
            cell.deleteBtn.hidden = YES;
            cell.gifLable.hidden = YES;
        }
        else
        {
            cell.imageView.image = _headSelectedPhotos[indexPath.row];
            cell.asset = _headSelectedAssets[indexPath.row];
            if(isShowDelete)
            {
                cell.deleteBtn.hidden = NO;
                
                cell.deleteBtn.tag = indexPath.row;
                [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                cell.deleteBtn.hidden = YES;
            }
        }
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(isShowWebImage)
    {
        if (indexPath.row == webImages.count)
        {
            [self pushImagePickerController];
        }
        else
        {
            [photos removeAllObjects];
            for(int i = 0;i < webImages.count;i++)
            {
                MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:webImages[i]]];
                photo.caption = [NSString stringWithFormat:@"%d", (i + 1)];
                [photos addObject:photo];
            }
            
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = YES;
            [browser setCurrentPhotoIndex:indexPath.row];
            UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
            nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            [self.presentVC presentViewController:nc animated:YES completion:nil];
        }
    }
    else
    {
        if (indexPath.row == _headSelectedPhotos.count)
        {
            [self pushImagePickerController];
        }
        else
        {
            id asset = _headSelectedAssets[indexPath.row];
            BOOL isVideo = NO;
            if ([asset isKindOfClass:[PHAsset class]])
            {
                PHAsset *phAsset = asset;
                isVideo = phAsset.mediaType == PHAssetMediaTypeVideo;
            }
            else if ([asset isKindOfClass:[ALAsset class]])
            {
                ALAsset *alAsset = asset;
                isVideo = [[alAsset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo];
            }
            if ([[asset valueForKey:@"filename"] containsString:@"GIF"])
            {
                TZGifPhotoPreviewController *vc = [[TZGifPhotoPreviewController alloc] init];
                TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypePhotoGif timeLength:@""];
                vc.model = model;
                [self.presentVC presentViewController:vc animated:YES completion:nil];
            }
            else if (isVideo)
            {
                // perview video / 预览视频
                TZVideoPlayerController *vc = [[TZVideoPlayerController alloc] init];
                TZAssetModel *model = [TZAssetModel modelWithAsset:asset type:TZAssetModelMediaTypeVideo timeLength:@""];
                vc.model = model;
                [self.presentVC presentViewController:vc animated:YES completion:nil];
            }
            else
            {
                // preview photos / 预览照片
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithSelectedAssets:_headSelectedAssets selectedPhotos:_headSelectedPhotos index:indexPath.row];
                imagePickerVc.maxImagesCount = maxImagesCount;
                imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto)
                 {
                     _headSelectedPhotos = [NSMutableArray arrayWithArray:photos];
                     _headSelectedAssets = [NSMutableArray arrayWithArray:assets];
                     _isSelectOriginalPhoto = isSelectOriginalPhoto;
                     [_collectionView reloadData];
                     if(self.currentCount){
                         self.currentCount(_headSelectedPhotos.count);
                     }
                     _collectionView.contentSize = CGSizeMake(0, ((_headSelectedPhotos.count + 2) / 3 ) * (_margin + kImageSize));
                   
                 }];
                [self.presentVC presentViewController:imagePickerVc animated:YES completion:nil];
            }
        }
    }
}

#pragma mark - LxGridViewDataSource
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.item < _headSelectedPhotos.count;
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath canMoveToIndexPath:(NSIndexPath *)destinationIndexPath
{
    return (sourceIndexPath.item < _headSelectedPhotos.count && destinationIndexPath.item < _headSelectedPhotos.count);
}

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)sourceIndexPath didMoveToIndexPath:(NSIndexPath *)destinationIndexPath
{
    UIImage *image = _headSelectedPhotos[sourceIndexPath.item];
    [_headSelectedPhotos removeObjectAtIndex:sourceIndexPath.item];
    [_headSelectedPhotos insertObject:image atIndex:destinationIndexPath.item];
    
    id asset = _headSelectedAssets[sourceIndexPath.item];
    [_headSelectedAssets removeObjectAtIndex:sourceIndexPath.item];
    [_headSelectedAssets insertObject:asset atIndex:destinationIndexPath.item];
    
    [_collectionView reloadData];
}

#pragma mark - TZImagePickerController
- (void)pushImagePickerController
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxImagesCount columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
#pragma mark - 四类个性化设置，这些参数都可以不传，此时会走默认设置
    imagePickerVc.isSelectOriginalPhoto = _isSelectOriginalPhoto;
    if (maxImagesCount > 1)
    {
        // 1.设置目前已经选中的图片数组
        imagePickerVc.selectedAssets = _headSelectedAssets; // 目前已经选中的图片数组
    }
    imagePickerVc.allowTakePicture = YES; // 在内部显示拍照按钮

    // 3. Set allow picking video & photo & originalPhoto or not
    imagePickerVc.allowPickingVideo = NO;
    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = YES;
    
    // 4. 照片排列按修改时间升序
    imagePickerVc.sortAscendingByModificationDate = YES;

    // 5. Single selection mode, valid when maxImagesCount = 1
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.circleCropRadius = 100;
    
#pragma mark - 到这里为止
    
    // You can get the photos by block, the same as by delegate.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {}];
    [self.presentVC presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker
{
#ifdef DEBUG
    NSLog(@"User click cancel button");
#endif
}

#pragma mark - Click Event delete image Btn
- (void)deleteBtnClik:(UIButton *)sender
{
    [_headSelectedPhotos removeObjectAtIndex:sender.tag];
    [_headSelectedAssets removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
        if(self.currentCount){
            self.currentCount(_headSelectedPhotos.count);
        }
    }];
}

/**
 * The picker should dismiss itself; when it dismissed these handle will be called.
 * If isOriginalPhoto is YES, user picked the original photo.
 * You can get original photo with asset, by the method [[TZImageManager manager] getOriginalPhotoWithAsset:completion:].
 * The UIImage Object in photos default width is 828px, you can set it by photoWidth property.
 */
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    if(isShowWebImage)
    {
        isShowWebImage = NO;
    }
 
        _headSelectedPhotos = [NSMutableArray arrayWithArray:photos];
        _headSelectedAssets = [NSMutableArray arrayWithArray:assets];
        _isSelectOriginalPhoto = isSelectOriginalPhoto;
        [_collectionView reloadData];
        if(self.currentCount){
            self.currentCount(_headSelectedPhotos.count);
        }
        [self printAssetsName:assets];
 
}

/**
 * If user picking a video, this callback will be called.
 * If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
 */
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset
{
    _headSelectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _headSelectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
    if(self.currentCount){
        self.currentCount(_headSelectedPhotos.count);
    }
}

/**
 * If user picking a gif image, this callback will be called.
 */
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset
{
    _headSelectedPhotos = [NSMutableArray arrayWithArray:@[animatedImage]];
    _headSelectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    [_collectionView reloadData];
    if(self.currentCount){
        self.currentCount(_headSelectedPhotos.count);
    }
}

#pragma mark - Private
- (void)printAssetsName:(NSArray *)assets
{
    NSString *fileName;
    for (id asset in assets)
    {
        if ([asset isKindOfClass:[PHAsset class]])
        {
            PHAsset *phAsset = (PHAsset *)asset;
            fileName = [phAsset valueForKey:@"filename"];
        }
        else if ([asset isKindOfClass:[ALAsset class]])
        {
            ALAsset *alAsset = (ALAsset *)asset;
            fileName = alAsset.defaultRepresentation.filename;;
        }
#ifdef DEBUG
        NSLog(@"图片名字:%@", fileName);
#endif
    }
}

- (void)loadWebImages:(NSArray *)webImagesArr
{
    if(nil != webImagesArr)
    {
        [webImages addObjectsFromArray:webImagesArr];
        if(webImages.count < 1)
        {
            isShowWebImage = false;
        }
        else
        {
            isShowWebImage = true;
        }
        [_collectionView reloadData];
        if(self.currentCount){
            self.currentCount(_headSelectedPhotos.count);
        }
    }
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    if (index < photos.count)
    {
        return [photos objectAtIndex:index];
    }
    return nil;
}

- (NSMutableArray *)getPhotos
{
    return _headSelectedPhotos;
}

- (void)isShowAddBtn:(BOOL)isShow
{
    isShowAddBtn = isShow;
}

@end
