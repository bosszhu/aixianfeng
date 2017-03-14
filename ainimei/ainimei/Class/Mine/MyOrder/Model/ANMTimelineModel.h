//
//  ANMTimelineModel.h
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANMTimelineModel : NSObject
//标题
@property (nonatomic, copy) NSString *status_title;
//描述
@property (nonatomic, copy) NSString *status_desc;
//时间
@property (nonatomic, copy) NSString *status_time;

+(instancetype)timelineModelWithDict:(NSDictionary *)dict;

@end
