//
//  ANMOrderDetailSecondCell.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderDetailSecondCell.h"

@interface ANMOrderDetailSecondCell ()
@property (weak, nonatomic) IBOutlet UILabel *receiveNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;


@end

@implementation ANMOrderDetailSecondCell

-(void)setOrderModel:(ANMMyOrderModel *)orderModel{
    _orderModel = orderModel;
    self.receiveNameLabel.text = orderModel.accept_name;
    self.adressLabel.text = orderModel.address;
    self.shopLabel.text = orderModel.dealer_name;
    self.phoneNumLabel.text = orderModel.telphone;
}

@end
