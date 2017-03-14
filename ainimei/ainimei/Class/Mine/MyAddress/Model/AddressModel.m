//
//  AddressModel.m
//  ainimei
//
//  Created by user on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "AddressModel.h"

@implementation AddressModel

+ (instancetype)addressModelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}
- (void)setAddress:(NSString *)address {
    //截取字符串
    _address = address;
    NSArray *addArray= [address componentsSeparatedByString:@" "];
    self.zone = addArray.firstObject;
    self.detailAddress = addArray.lastObject;

}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
}



@end
