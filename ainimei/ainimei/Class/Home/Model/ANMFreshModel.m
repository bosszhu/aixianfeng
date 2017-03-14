//
//  ANMFreshModel.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFreshModel.h"


//新鲜热卖的model
@implementation ANMFreshModel

+(instancetype)freshModelWithDict:(NSDictionary *)dict{
    id obj = [[self alloc]init];
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

+(NSDictionary*)AFM_replacedKeyFromPropertyName
{
    return @{@"gid":@"id"};
}
//定义拷贝方法


@end
