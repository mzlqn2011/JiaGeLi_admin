//
//  CommentModel.h
//  JiaGeLi_admin
//
//  Created by LTY on 2019/8/17.
//  Copyright © 2019 mac. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommentModel : BaseModel
@property (nonatomic, copy) NSString *addtime;//评价时间
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *photo;//图片地址，多个逗号隔开，取第一个
@property (nonatomic, copy) NSString *pname;//产品名称
@property (nonatomic, copy) NSString *starts;//评星
@property (nonatomic, copy) NSString *username;//安全码，认证时候用到
@property (nonatomic, copy) NSString *thumb_src;//产品图片路径

@end

NS_ASSUME_NONNULL_END


