//
//  ANMBtnModel.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ANMBtnModel : NSObject

//首页第二行按钮

//标题
@property (nonatomic, copy) NSString *name;

//图片地址
@property (nonatomic, copy) NSString *img;

//跳转地址
@property (nonatomic, copy) NSString *customURL;

+(instancetype)btnModelWithDict:(NSDictionary *)dict;

@end
