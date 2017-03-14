//
//  ANMOrderDetailFirstCell.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderDetailFirstCell.h"

@interface ANMOrderDetailFirstCell ()

//订单号
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *recieveLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *diliveryTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *diliveryTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payTypeLabel;

@end

@implementation ANMOrderDetailFirstCell

-(void)setOrderModel:(ANMMyOrderModel *)orderModel{
    _orderModel = orderModel;
    self.orderNumLabel.text = orderModel.order_no;
    self.recieveLabel.text = orderModel.checknum;
    self.orderTimeLabel.text = orderModel.create_time;
    self.diliveryTimeLabel.text = orderModel.accept_time;
//    self.diliveryTypeLabel.text = orderModel.distribution;因为没有说明类型,所以没有做转化
//    self.payTypeLabel.text = orderModel.pay_type;
    self.diliveryTypeLabel.text = @"送货上门";
    self.payTypeLabel.text = @"在线支付";
    
}


@end
