//
//  ANMOrderDetailCell.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderDetailCell.h"

@interface ANMOrderDetailCell ()
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@end

@implementation ANMOrderDetailCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    UILabel* nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:14];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    UILabel* numLabel = [UILabel new];
    numLabel.font = [UIFont systemFontOfSize:14];
    self.numLabel = numLabel;
    [self addSubview:numLabel];
    
    UILabel* priceLabel = [UILabel new];
    priceLabel.font = [UIFont systemFontOfSize:14];
    self.priceLabel = priceLabel;
    [self addSubview:priceLabel];
    priceLabel.textAlignment = NSTextAlignmentRight;
    
    
    
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.nameLabel.frame = CGRectMake(10, 5, 200, 25);
    self.numLabel.frame = CGRectMake(270, 5, 30, 25);
    self.priceLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 78, 5, 70, 25);
   
}

-(void)setGoodsModel:(ANMGoodsModel *)goodsModel{
    _goodsModel = goodsModel;
    self.nameLabel.text = goodsModel.name;
    self.numLabel.text = [NSString stringWithFormat:@"x%@",goodsModel.goods_nums];
    self.priceLabel.text = [NSString stringWithFormat:@"$%@",goodsModel.goods_price];
    
}


@end
