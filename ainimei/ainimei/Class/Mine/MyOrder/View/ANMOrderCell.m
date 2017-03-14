//
//  ANMOrderCell.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderCell.h"
#import <UIImageView+WebCache.h>

@interface ANMOrderCell ()
@property (nonatomic, weak) UIImageView *imageViewOne;
@property (nonatomic, weak) UIImageView *imageViewTwo;
@property (nonatomic, weak) UIImageView *imageViewThree;
@property (nonatomic, weak) UIImageView *imageViewFour;
@property (nonatomic, weak) UIImageView *imageViewFive;

@end

@implementation ANMOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    UIImageView *imageViewOne = [[UIImageView alloc]init];
    [self addSubview:imageViewOne];
    self.imageViewOne = imageViewOne;
    
    UIImageView *imageViewTwo = [[UIImageView alloc]init];
    [self addSubview:imageViewTwo];
    self.imageViewTwo = imageViewTwo;
    
    UIImageView *imageViewThree = [[UIImageView alloc]init];
    [self addSubview:imageViewThree];
    self.imageViewThree = imageViewThree;
    
    UIImageView *imageViewFour = [[UIImageView alloc]init];
    [self addSubview:imageViewFour];
    self.imageViewFour = imageViewFour;
    
    UIImageView *imageViewFive = [[UIImageView alloc]init];
    [self addSubview:imageViewFive];
    self.imageViewFive = imageViewFive;
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.imageViewOne.frame = CGRectMake(10, 5, 30, 30);
    self.imageViewTwo.frame = CGRectMake(45, 5, 30, 30);
    self.imageViewThree.frame = CGRectMake(80, 5, 30, 30);
    self.imageViewFour.frame = CGRectMake(115, 5, 30, 30);
    self.imageViewFive.frame = CGRectMake(150, 5, 30, 30);
}

-(void)setGoodsArr:(NSArray<ANMGoodsModel *> *)goodsArr{
    _goodsArr = goodsArr;
    NSArray<ANMGoodsModel *> *newArr = [self transferFromOriginArr:goodsArr];
    
    if (goodsArr.count <=4) {
        self.imageViewFive.image = nil;
        
    }else{
        self.imageViewFive.image = [UIImage imageNamed:@"v2_goodmore"];
    }
    [self.imageViewOne sd_setImageWithURL:[NSURL URLWithString:newArr[0].img]];
    [self.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:newArr[1].img]];
    [self.imageViewThree sd_setImageWithURL:[NSURL URLWithString:newArr[2].img]];
    [self.imageViewFour sd_setImageWithURL:[NSURL URLWithString:newArr[3].img]];
}

-(NSArray<ANMGoodsModel *> *)transferFromOriginArr:(NSArray<ANMGoodsModel *> *)goodsArr{
    if (goodsArr.count <=4) {
        NSMutableArray *newArr = [NSMutableArray new];
        for (NSUInteger i = 0; i<goodsArr.count; i ++) {
            [newArr addObject:goodsArr[i]];
        }
        for (NSUInteger i = goodsArr.count; i <5; i ++) {
            ANMGoodsModel *model = [ANMGoodsModel new];
            model.img = nil;
            [newArr addObject:model];
        }
        return newArr;
    }else{
        return goodsArr;
    }
}


@end
