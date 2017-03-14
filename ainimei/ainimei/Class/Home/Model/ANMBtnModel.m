//
//  ANMBtnModel.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMBtnModel.h"

@implementation ANMBtnModel

+(instancetype)btnModelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
