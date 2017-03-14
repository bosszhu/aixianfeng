//
//  VipModel.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "VipModel.h"

@implementation VipModel
+ (instancetype)vipModelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}
@end
