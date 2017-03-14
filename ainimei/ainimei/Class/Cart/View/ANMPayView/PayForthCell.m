//
//  PayForthCell.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "PayForthCell.h"
#import "ANMCartSingle.h"

@interface PayForthCell ()
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeLabel;


@end

@implementation PayForthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.sumPriceLabel.text =[NSString stringWithFormat:@"$%.1f",[ANMCartSingle sharedCart].sumPrice];
}

-(void)setCouponModel:(CouponModel *)couponModel{
    self.freeLabel.text = couponModel.value;
}


@end
