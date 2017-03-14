//
//  ANMPayProductCell.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMPayProductCell.h"
#import <Masonry.h>
@interface ANMPayProductCell()
//商品名字
@property (nonatomic, weak) UILabel *productNameLabel;
//商品总价格价格
@property (nonatomic, weak) UILabel *productPriceLabel;
//商品数量
@property (nonatomic, weak) UILabel *productNumLabel;


@end

@implementation ANMPayProductCell

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
    productNameLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel* productPriceLabel = [UILabel new];
    [self addSubview:productPriceLabel];
    self.productPriceLabel = productPriceLabel;
    productPriceLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *productNumLabel = [UILabel new];
    [self addSubview:productNumLabel];
    self.productNumLabel = productNumLabel;
    productNumLabel.font = [UIFont systemFontOfSize:13];
    productNumLabel.textAlignment = NSTextAlignmentCenter;
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //masonry做约束
    [self.productPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.top.mas_equalTo(self).offset(10);
    }];
    
    [self.productNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(self).offset(10);
        make.width.mas_equalTo(170);
    }];

    [self.productNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-100);
        make.top.mas_equalTo(self).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 20));
    }];
  
    
}

-(void)setFreshModel:(ANMFreshModel *)freshModel{
//    _freshModel= freshModel;
    self.productNameLabel.text = [NSString stringWithFormat:@"[精选]%@",freshModel.name];
    self.productPriceLabel.text = [NSString stringWithFormat:@"$%.1f",freshModel.price.floatValue *(freshModel.count +1)];
    self.productNumLabel.text =  [NSString stringWithFormat:@"x%zd",freshModel.count +1 ];
}

@end
