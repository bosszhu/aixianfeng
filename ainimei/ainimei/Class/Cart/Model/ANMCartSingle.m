//
//  ANMCartSingle.m
//  ainimei
//
//  Created by kingLee on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMCartSingle.h"

//单例负责存取档案
@implementation ANMCartSingle

+(instancetype)sharedCart{
    static ANMCartSingle * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        NSMutableArray *arr = [NSMutableArray new];
        instance.freshModelArr = arr;
    });
    return instance;
}

//增加数组成员方法时,做一个自动合并
-(void)addFreshModelArrObject:(ANMFreshModel *)object{
    
    //执行添加合并,改为判定名字是否相等
    int i = 0;
    for (i = 0; i < self.freshModelArr.count; i++) {
        if ([self.freshModelArr[i].name isEqualToString: object.name]) {
            self.freshModelArr[i].count += 1;
            break;
        }
    }
    if (i == self.freshModelArr.count ) {
        [self.freshModelArr addObject:[self newModelFromOld: object]];
    }
    
}

//添加成员的方法有bug,需要添加的时候把cout置0
-(ANMFreshModel *)newModelFromOld:(ANMFreshModel *)oldModel{
    ANMFreshModel *freshModel =[[ANMFreshModel alloc]init];
    freshModel.name = oldModel.name;
    freshModel.price = oldModel.price;
    freshModel.pm_desc = oldModel.pm_desc;
    freshModel.count = 0;
    freshModel.img = oldModel.img;
    freshModel.specifics = oldModel.specifics;
    return freshModel;
}


//删除成员方法
-(void)removeFreshModelArrObject:(ANMFreshModel *)object{
    if (self.count == 0) {
        return;
    }
    for (ANMFreshModel *model in self.freshModelArr) {
        if ([model.name isEqualToString:object.name]) {
            if (model.count == 0) {
                [self.freshModelArr removeObject:model];
                break;
            }else{
                model.count -= 1;
                break;
            }
        }
    }
}



//懒加载
-(NSMutableArray<ANMFreshModel *> *)freshModelArr{
    if (_freshModelArr == nil) {
        _freshModelArr = [NSMutableArray new];
    }
    return _freshModelArr;
}

-(NSUInteger)count{
    NSUInteger sum = 0;
    for (ANMFreshModel *model  in self.freshModelArr) {
        sum = sum + model.count + 1;
    }
    
    return sum;
}

-(float)sumPrice{
    float sum = 0;
    for (ANMFreshModel *model  in self.freshModelArr) {
        sum = sum + model.price.floatValue * ( model.count + 1);
    }
    return sum;
    
}

-(void)removeAllFreshModel{
    [_freshModelArr removeAllObjects];
}

@end
