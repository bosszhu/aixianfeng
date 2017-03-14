//
//  ANMFeeModel.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFeeModel.h"

@implementation ANMFeeModel



+(instancetype)feeModelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
