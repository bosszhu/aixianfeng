//
//  ANMFooterView.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFooterView.h"
#import "ANMFooterViewLayout.h"
#import "ANMFooterViewCell.h"
#import "DSHTTPClient.h"
#import "ANMGoodDetailVc.h"

@interface ANMFooterView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, weak)UICollectionView  *collectionView;
@property (nonatomic, strong) NSArray<ANMFreshModel*> *freshModelArr;
@end

@implementation ANMFooterView
static NSString *cellID = @"footerCell";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame callNum:(NSString *)callNum urlString:(NSString *)urlString andIsHidenCell:(BOOL)isHidden{
    if (self = [super initWithFrame:frame]) {
        self.callNum = callNum;
        self.requestUrl = urlString;
        self.isHidden = isHidden;
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

//-(void)setFreshModelArr:(NSArray<ANMFreshModel *> *)freshModelArr{
//
//    _freshModelArr = freshModelArr;
//    [self.collectionView reloadData];
//}
//设计UI
-(void)setupUI{
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[ANMFooterViewLayout new] ];
    collectionView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    
    [collectionView registerClass:[ANMFooterViewCell class] forCellWithReuseIdentifier:cellID];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}
//布局
-(void)layoutSubviews{
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

//懒加载

-(NSArray<ANMFreshModel *> *)freshModelArr{
    if (_freshModelArr == nil) {
        _freshModelArr = [NSArray new];
       
        NSMutableDictionary *param = [NSMutableDictionary dictionary];
        
        [param setValue:@"2" forKey:@"call"];
        
        // http://iosapi.itcast.cn/loveBeen/focus.json.php
        
        //字典转模型数组
        NSMutableArray *mArrTemp = [NSMutableArray new];
        [DSHTTPClient postUrlString:@"firstSell.json.php" withParam:param withSuccessBlock:^(id data) {
            NSArray *dataArr = data[@"data"];
            for (NSDictionary *modelDic in dataArr) {
                ANMFreshModel *model = [ANMFreshModel freshModelWithDict:modelDic];
                [mArrTemp addObject:model];
            }
            self.freshModelArr = mArrTemp;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
            //把值用set方法传给子footerView
            
        } withFailedBlock:^(NSError *error) {
            NSLog(@"%@",error);
        } withErrorBlock:^(NSString *message) {
            NSLog(@"%@",message);
        }];

    }
    return _freshModelArr;
}

#pragma mark - 数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.freshModelArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ANMFooterViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    cell.freshModel = self.freshModelArr[indexPath.item];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ANMGoodDetailVc *detailVc = [ANMGoodDetailVc new];
    //使用方法：
    detailVc.freshModel = self.freshModelArr[indexPath.row];
    [[self viewController].navigationController pushViewController:detailVc animated:YES];
}

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}



@end
