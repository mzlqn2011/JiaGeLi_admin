//
//  CommentTableViewCell.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "UIButton+WebCache.h"
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon.layer.cornerRadius = 20;
    self.icon.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(CommentModel *)model{
    NSString * imgs = [NSString stringWithFormat:@"%@%@",ImgRootUrl,model.thumb_src];    [self.icon sd_setImageWithURL:[NSURL URLWithString:imgs] placeholderImage:[UIImage imageNamed:@"defult"]];
    self.name.text =model.username;
    self.level.text =[NSString stringWithFormat:@"给了%ld星评价",[model.starts integerValue]];;//评星
    self.comment.text =model.content;
    self.time.text =model.addtime;//评价时间
    NSString * s = @"";
    [self.goodBtn sd_setImageWithURL:[NSURL URLWithString:s] forState:UIControlStateNormal];
    [self.goodBtn setTitle:model.pname forState:UIControlStateNormal];//产品名称
}
@end
