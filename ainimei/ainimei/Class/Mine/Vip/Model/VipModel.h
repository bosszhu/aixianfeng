//
//  VipModel.h
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VipModel : NSObject

@property (nonatomic, copy) NSString *icnImage;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *text;


+ (instancetype)vipModelWithDict:(NSDictionary *)dict;
@end
