//
//  ANMProductCell.m
//  ainimei
//
//  Created by kingLee on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMProductCell.h"
#import <Masonry.h>
#import <SVProgressHUD.h>



@implementation ANMProductCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    
    UILabel* productNameLabel = [UILabel new];
    [self addSubview:productNameLabel];
    self.productNameLabel = productNameLabel;
    productNameLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel* productPriceLabel = [UILabel new];
    [self addSubview:productPriceLabel];
    self.productPriceLabel = productPriceLabel;
    productPriceLabel.font = [UIFont systemFontOfSize:15];
    
    UILabel *productNumLabel = [UILabel new];
    [self addSubview:productNumLabel];
    self.productNumLabel = productNumLabel;
    productNumLabel.font = [UIFont systemFontOfSize:15];
    productNumLabel.textAlignment = NSTextAlignmentCenter;
    
    UIButton *minusBtn =[UIButton new];
    [self addSubview:minusBtn];
    [minusBtn setBackgroundImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
    self.minusBtn = minusBtn;
    [minusBtn addTarget:self action:@selector(postMinusNotificaiton) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * plusBtn = [UIButton new];
    [self addSubview:plusBtn];
    self.plusBtn = plusBtn;
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(postPlusNotification) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //masonry做约束
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(10);
        make.width.mas_equalTo(200);
    }];
    
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.productNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.plusBtn.mas_left).offset(-2);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.productNumLabel.mas_left).offset(-5);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.minusBtn.mas_left).offset(-5);
        make.top.mas_equalTo(self).offset(10);
    }];
    
}


-(void)setFreshModel:(ANMFreshModel *)freshModel{
    _freshModel = freshModel;
    self.productNameLabel.text = [NSString stringWithFormat:@"[精选]%@",freshModel.name];
    self.productPriceLabel.text = [NSString stringWithFormat:@"$%@",freshModel.price];
    self.productNumLabel.text =  [NSString stringWithFormat:@"%zd",freshModel.count +1 ];
}

//注意此时发送通知传的对象的cout数并不为0,所以要置0后再传
-(void)postPlusNotification{
    //如果数量超过20,发出警告,并不增加商品个数
    if (self.productNumLabel.text.integerValue >= 20) {
        [self showHUD:@"商品已达上限"];
        return;
        
    }
    
    //自定义,复制model,为了使复制后的model的pricecount 为0;
    ANMFreshModel *freshModel =[self newModelFromOld:self.freshModel];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addToCartInCart" object:freshModel userInfo:nil];
    
}

-(void)postMinusNotificaiton{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"minusFromCart" object:[self newModelFromOld:self.freshModel] userInfo:nil];
}

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

- (void)showHUD:(NSString *)HUDString {
    [SVProgressHUD showErrorWithStatus:HUDString];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}

@end
