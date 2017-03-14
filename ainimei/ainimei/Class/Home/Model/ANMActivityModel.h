//
//  ANMActivityModel.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

//活动cell的model
@interface ANMActivityModel : NSObject

//活动名
@property (nonatomic, copy) NSString *name;

//活动图片地址
@property (nonatomic, copy) NSString *img;

//活动跳转地址
@property (nonatomic, copy) NSString *customURL;

+(instancetype)activityModelWithDict:(NSDictionary *)dict;

@end
