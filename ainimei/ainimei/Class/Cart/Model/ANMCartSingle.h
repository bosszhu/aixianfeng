//
//  ANMCartSingle.h
//  ainimei
//
//  Created by kingLee on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ANMFreshModel.h"
#import "AddressModel.h"

//这是个全局保存购物车物品的单例
@interface ANMCartSingle : NSObject

@property (nonatomic, strong) NSMutableArray <AddressModel *>*addressArr;
//保存购物车的物品,注意是合并后的物品
@property (nonatomic, strong) NSMutableArray<ANMFreshModel*> *freshModelArr;
//记录总的商品数目的属性(包括重复)
@property (nonatomic, assign) NSUInteger count;

//计算总价格
@property (nonatomic, assign) float sumPrice;

//初始化方法
+(instancetype)sharedCart;

//add数组属性的时候一定要调用这个方法!
-(void)addFreshModelArrObject:(ANMFreshModel *)object;

//减少数组元素的方法!
-(void)removeFreshModelArrObject:(ANMFreshModel *)object;
//删除所有物品
-(void)removeAllFreshModel;


-(NSUInteger)count;

-(float)sumPrice;

@end
