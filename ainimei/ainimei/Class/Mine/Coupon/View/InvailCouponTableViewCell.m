//
//  InvailCouponTableViewCell.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "InvailCouponTableViewCell.h"
#import "CouponModel.h"

@interface InvailCouponTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *yuanImageView;
@property (weak, nonatomic) IBOutlet UILabel *valueLable;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *validityLable;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLable;
@end
@implementation InvailCouponTableViewCell


- (void)setCouponModel:(CouponModel *)couponModel {
    _couponModel = couponModel;
    self.yuanImageView.layer.cornerRadius = 30;
    self.yuanImageView.layer.masksToBounds = YES;
    
    NSString *str = [NSString stringWithFormat:@"$%zd",couponModel.value.integerValue];
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
