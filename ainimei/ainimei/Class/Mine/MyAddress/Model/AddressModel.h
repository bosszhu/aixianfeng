//
//  AddressModel.h
//  ainimei
//
//  Created by user on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

/**
 模型下标
 */
@property (nonatomic, assign) NSInteger index;

/**
 增还是减
 */
@property (nonatomic, assign,getter=isAddModel) BOOL addModel;
/**
 收货人姓名
 */
@property (nonatomic, copy) NSString *accept_name;

/**
 性别(1代表男,0代表女)
 */
@property (nonatomic, copy) NSString *gender;

/**
 联系电话
 */
@property (nonatomic, copy) NSString *telphone;

/**
 城市
 */
@property (nonatomic, copy) NSString *city_name;

/**
 详细地址
 */
@property (nonatomic, copy) NSString *address;

/**
 所在地区
 */
@property (nonatomic, copy) NSString *zone;
/**
 详细地址
 */
@property (nonatomic, copy) NSString *detailAddress;


+ (instancetype)addressModelWithDict:(NSDictionary *)dict;


@end
