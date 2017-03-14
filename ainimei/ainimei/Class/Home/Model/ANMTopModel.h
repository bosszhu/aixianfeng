//
//  ANMTopModel.h
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>

//用于顶部轮播器的模型
@interface ANMTopModel : NSObject

//图片名
@property (nonatomic, copy) NSString *name;

//图片地址
@property (nonatomic, copy) NSString *img;

//跳转地址
@property (nonatomic, copy) NSString *toURL;

+(instancetype)topModelWihtDict:(NSDictionary*)dict;


@end
