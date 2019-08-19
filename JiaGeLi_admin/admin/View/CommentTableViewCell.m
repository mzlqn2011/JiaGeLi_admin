//
//  CommentTableViewCell.m
//  JiaGeLi
//
//  Created by LTY on 2019/8/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(CommentModel *)model{
    NSString * imgs = [NSString stringWithFormat:@"%@",model.thumb_src];    [self.icon sd_setImageWithURL:[NSURL URLWithString:imgs] placeholderImage:[UIImage imageNamed:@"defult"]];
    self.name.text =model.pname;//产品名称
    self.level.text =model.starts;//评星
    self.comment.text =model.content;
    self.time.text =model.addtime;//评价时间

}
@end
