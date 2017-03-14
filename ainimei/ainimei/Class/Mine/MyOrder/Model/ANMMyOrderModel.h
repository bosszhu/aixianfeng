//
//  ANMMyOrderModel.h
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANMGoodsModel.h"
#import "ANMTimelineModel.h"
#import "ANMFeeModel.h"

@interface ANMMyOrderModel : NSObject

//订单号
@property (nonatomic, copy) NSString *order_no;
//收货码
@property (nonatomic, copy) NSString *checknum;
//下单时间
@property (nonatomic, copy) NSString *create_time;
//配送时间
@property (nonatomic, copy) NSString *accept_time;
//电话
@property (nonatomic, copy) NSString *telphone;
//配送方式
@property (nonatomic, copy) NSString *distribution;
//支付方式
@property (nonatomic, copy) NSString *pay_type;
//备注信息

//支付时间
@property (nonatomic, copy) NSString *pay_time;

//实付
@property (nonatomic, copy) NSString *real_amount;



//收货人
@property (nonatomic, copy) NSString *accept_name;
//收货地址
@property (nonatomic, copy) NSString *address;
//配送店铺
@property (nonatomic, copy) NSString *dealer_name;



//评价星数
@property (nonatomic, assign) NSNumber* star;
//评价
@property (nonatomic, copy) NSString *comment;

//拥有的物品数组
@property (nonatomic, strong) NSArray<ANMGoodsModel *> *order_goods;

//转化成归并后的物品数组,需要写set方法


//时间轴数组
@property (nonatomic, strong) NSArray<ANMTimelineModel*> *timelines;

//费用数组
@property (nonatomic, strong) NSArray<ANMFeeModel*> *fees;


//右侧按钮名字
@property (nonatomic, copy) NSString *myFirstName;

//下册按钮名字
@property (nonatomic, copy) NSString *bottomName;

//自定义商品总数量
@property (nonatomic, assign) NSUInteger myCount;


+(instancetype)orderModelWithDict:(NSDictionary *)dict;



@end
