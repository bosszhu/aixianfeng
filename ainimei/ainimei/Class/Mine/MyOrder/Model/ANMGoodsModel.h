//
//  ANMGoodsModel.h
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANMGoodsModel : NSObject

//商品名
@property (nonatomic, copy) NSString *name;
//商品图片
@property (nonatomic, copy) NSString *img;
//商品价格
@property (nonatomic, copy) NSString *goods_price;
//商品数量
@property (nonatomic, copy) NSString *goods_nums;



+(instancetype)goodsModelWithDict:(NSDictionary *)dict;

@end
