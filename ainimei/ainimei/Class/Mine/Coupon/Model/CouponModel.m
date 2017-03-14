//
//  CouponModel.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "CouponModel.h"


@implementation CouponModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Description" : @"description"};
}

- (void)setValue:(NSString *)value {
    //5.00截取字符串前面加$
    NSString *str = [value substringToIndex:1];
//    str = [@"$" stringByAppendingString:str];
    _value = str;
}

- (NSString *)dateDescription {
    NSString *dateStr = [NSString stringWithFormat:@"有效期: %@至%@",self.start_time,self.end_time];
    return dateStr;
}
/**
 确定是否过期
 */
- (void)setEnd_time:(NSString *)end_time {
    _end_time = end_time;
    //比较当前时间获取
//    格式:2018-12-09
    NSString *endTime = end_time;
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc]init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [inputFormatter dateFromString:endTime];
    NSDate *currentDate = [NSDate date];
    NSComparisonResult result = [currentDate compare:endDate];
    if (result < 0) {
        self.expired = NO;
    } else {
        self.expired = YES;
    }
}
@end
