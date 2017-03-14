//
//  ANMFlsahMarketSource.h
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^CompleteBlock)(id data,NSError *error);
@class SuperMarketData;
@class ProductCategory;
@class Products;
@class ANMFreshModel;

@interface ANMFlsahMarketSource : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic,strong)SuperMarketData *data;

+ (void)loadSupermarketData:(CompleteBlock)complete;
+ (instancetype)marketSourceWith:(NSDictionary *)dict;

@end


@interface SuperMarketData:NSObject

@property (nonatomic,strong)NSArray<ProductCategory *> *categories;

@property (nonatomic,strong)id products;


@end


@interface ProductCategory:NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, strong) NSArray *products;

@end
