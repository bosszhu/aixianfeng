//
//  ANMFlsahMarketSource.m
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFlsahMarketSource.h"
#import "DSHTTPClient.h"
#import "ANMFreshModel.h"
#import "YYModel.h"
#import "MJExtension.h"


@implementation ANMFlsahMarketSource

+ (instancetype)marketSourceWith:(NSDictionary *)dict{
    ANMFlsahMarketSource *source = [[ANMFlsahMarketSource alloc]init];
    [source setValuesForKeysWithDictionary:dict];
    return source;
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
+(void)loadSupermarketData:(CompleteBlock)complete
{

    NSMutableDictionary *param = [NSMutableDictionary dictionary];
   
    [param setValue:@"5" forKey:@"call"];
    
    
    [DSHTTPClient postUrlString:@"supermarket.json.php" withParam:param withSuccessBlock:^(id data) {
        

        ANMFlsahMarketSource *source = [ANMFlsahMarketSource mj_objectWithKeyValues:data];

        SuperMarketData *superMarketData = source.data;
        
        for (NSInteger i = 0; i < superMarketData.categories.count; i++) {
            ProductCategory *catgeory = superMarketData.categories[i];
            
            NSArray *productsArr = superMarketData.products[catgeory.id];
            
            catgeory.products = [ANMFreshModel mj_objectArrayWithKeyValuesArray:productsArr];
        }
        complete(superMarketData,nil);
       
       
    } withFailedBlock:^(NSError *error) {
        //        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        //        NSLog(@"%@",message);
    }];
    

}
@end

@implementation SuperMarketData
+(NSDictionary*)mj_objectClassInArray
{
    return @{@"categories":NSStringFromClass([ProductCategory class])};
}
@end


@implementation ProductCategory
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"products":NSStringFromClass([ANMFreshModel class])};
}
@end
    

