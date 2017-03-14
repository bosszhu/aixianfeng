//
//  CouponTableViewCell.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "CouponTableViewCell.h"
#import "CouponModel.h"

@interface CouponTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *yuanImageView;
@property (weak, nonatomic) IBOutlet UILabel *valueLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *validityLable;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;

@end
@implementation CouponTableViewCell

- (void)setCouponModel:(CouponModel *)couponModel {
    _couponModel = couponModel;
    self.yuanImageView.layer.cornerRadius = 30;
    self.yuanImageView.layer.masksToBounds = YES;
    NSString *str = [NSString stringWithFormat:@"$%zd",couponModel.value];
    self.valueLable.text = str;
    self.nameLable.text = couponModel.name;
    self.validityLable.text = couponModel.dateDescription;
    self.descriptionLable.text = couponModel.Description;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


@end
