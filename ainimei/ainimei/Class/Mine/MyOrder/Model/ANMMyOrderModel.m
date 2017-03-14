//
//  ANMMyOrderModel.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMMyOrderModel.h"


@implementation ANMMyOrderModel


+(instancetype)orderModelWithDict:(NSDictionary *)dict{
    ANMMyOrderModel * obj = [[ANMMyOrderModel alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    //进行商品解析
    NSMutableArray<ANMGoodsModel *> *newArr = [NSMutableArray new];
    NSArray *goodArr = dict[@"order_goods"];
    NSUInteger sum = 0;
    for (NSArray *innerArr in goodArr) {
        for (NSDictionary *innerDict in innerArr) {
            ANMGoodsModel *model = [ANMGoodsModel goodsModelWithDict:innerDict];
            //每次增加的时候遍历存储器
            NSUInteger i =0;
            for ( i = 0; i<newArr.count; i++) {
                if ([newArr[i].name isEqualToString:model.name]) {
                    NSUInteger newSum = newArr[i].goods_nums.integerValue +model.goods_nums.integerValue;
                    newArr[i].goods_nums = [NSString stringWithFormat:@"%zd",newSum];
                    break;
                }
            }
            if (i == newArr.count) {
                [newArr addObject:model];
            }
    
            sum += model.goods_nums.integerValue;
        }
    }
    obj.myCount = sum;
    obj.order_goods = newArr;
    
    //进行时间轴解析
    NSMutableArray *timeArr = [NSMutableArray new];
    NSArray *timeDictArr = dict[@"status_timeline"];
    for (NSDictionary *timeDict in timeDictArr) {
        ANMTimelineModel *timeModel = [ANMTimelineModel timelineModelWithDict:timeDict];
        [timeArr addObject:timeModel];
    }
    obj.timelines = timeArr;
    
    
    //进行费用解析
    NSMutableArray *feeArr = [NSMutableArray new];
    NSArray* feeDictArr = dict[@"fee_list"];
    for (NSDictionary *feeDict in feeDictArr) {
        ANMFeeModel *feeModel = [ANMFeeModel feeModelWithDict:feeDict];
        [feeArr addObject:feeModel];
    }
    obj.fees = feeArr;
    
    //解析右部按钮名字
    NSArray *nameArr = dict[@"buttons"];
    NSDictionary *nameDic = nameArr[0];
    obj.myFirstName = nameDic[@"text"];
    
    //解析底部按钮名字
    NSArray *bottomArr = dict[@"detail_buttons"];
    NSDictionary *bottomDic = bottomArr[0];
    obj.bottomName = bottomDic[@"text"];
    
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}



@end
