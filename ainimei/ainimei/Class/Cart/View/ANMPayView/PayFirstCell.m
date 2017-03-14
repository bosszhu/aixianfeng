//
//  PayFirstCell.m
//  ainimei
//
//  Created by kingLee on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "PayFirstCell.h"

@interface PayFirstCell ()
@property (weak, nonatomic) IBOutlet UILabel *freeTicketLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation PayFirstCell

-(void)setCouponModel:(CouponModel *)couponModel{
    self.freeTicketLabel.text = couponModel.name;
    self.priceLabel.text = couponModel.value;
    
}

@end
