//
//  ANMFeeModel.h
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANMFeeModel : NSObject
//费用名
@property (nonatomic, copy) NSString *text;

//费用
@property (nonatomic, copy) NSString *value;

+(instancetype)feeModelWithDict:(NSDictionary *)dict;


@end
