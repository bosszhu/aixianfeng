//
//  VipTableViewCell.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "VipTableViewCell.h"
#import "VipModel.h"

#define TEXT_FONT [UIFont systemFontOfSize:13]

@interface VipTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellIamgeView;
@property (weak, nonatomic) IBOutlet UILabel *cellNameLable;
@property (weak, nonatomic) IBOutlet UILabel *cellTextLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end
@implementation VipTableViewCell


- (void)setModel:(VipModel *)model {
    _model = model;
    self.cellIamgeView.image = [UIImage imageNamed:model.icnImage];
    self.cellNameLable.text = model.title;
    self.cellTextLable.text = model.text;
    // 获取到Lable的大小
//    CGSize textSize = [self.cellTextLable.text boundingRectWithSize:CGSizeMake(249, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName :  TEXT_FONT } context:nil].size;
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    
}
- (void)loadDetailLinesByDict:(NSDictionary *)dataDict {
    [self layoutIfNeeded];
    
    //Calculate the cell's height based on AutoLayout
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    self.rowHeight = size.height;
}

@end
