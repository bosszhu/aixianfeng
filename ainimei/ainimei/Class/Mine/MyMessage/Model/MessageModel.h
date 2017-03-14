//
//  MessageModel.h
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageModel : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 内容
 */
@property (nonatomic, copy) NSString *content;

+ (instancetype)messageModelWithDict:(NSDictionary *)dict;
@end
