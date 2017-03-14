//
//  CouponModel.h
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YYModel.h>

@interface CouponModel : NSObject

/**
 优惠券名
 */
@property (nonatomic, copy) NSString *name;

/**
 价值
 */
@property (nonatomic, copy) NSString *value;

/**
 优惠券描述
 */
@property (nonatomic, copy) NSString *Description;

/**
 开始时间
 */
@property (nonatomic, copy) NSString *start_time;

/**
 结束时间
 */
@property (nonatomic, copy) NSString *end_time;

/**
 时间描述
 */
@property (nonatomic, copy) NSString *dateDescription;

/**
 是否过期
 */
@property (nonatomic, assign,getter=isExpired) BOOL expired;
@end
