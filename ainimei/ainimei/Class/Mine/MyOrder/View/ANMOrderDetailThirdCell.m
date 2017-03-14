//
//  ANMOrderDetailThirdCell.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderDetailThirdCell.h"
#import "ANMFeeModel.h"

@interface ANMOrderDetailThirdCell ()
@property (weak, nonatomic) IBOutlet UILabel *diliveryFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *severiceFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeFeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalFeeLabel;


@end

@implementation ANMOrderDetailThirdCell

-(void)setOrderModel:(ANMMyOrderModel *)orderModel{
    _orderModel = orderModel;
    self.diliveryFeeLabel.text =[NSString stringWithFormat:@"$%@", orderModel.fees[0].value];
    self.severiceFeeLabel.text = [NSString stringWithFormat:@"$%@", orderModel.fees[1].value];
    self.freeFeeLabel.text = [NSString stringWithFormat:@"$%@", orderModel.fees[2].value];
    self.totalFeeLabel.text = [NSString stringWithFormat:@"$%@", orderModel.real_amount];
    
}

@end
