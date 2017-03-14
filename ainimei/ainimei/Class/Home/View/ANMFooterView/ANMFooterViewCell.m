//
//  ANMFooterViewCell.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFooterViewCell.h"
#import <UIImageView+WebCache.h>
#import "ANMCartSingle.h"
#import <SVProgressHUD.h>

@interface ANMFooterViewCell ()
//展示图片
@property (nonatomic, weak) UIImageView *freshImageView;
//商品名称
@property (nonatomic, weak) UILabel *freshNameLabel;
//商品促销
@property (nonatomic, weak) UILabel *freshMaiLabel;
//计量单位
@property (nonatomic, weak) UILabel *freshNumLabel;
//价格
@property (nonatomic, weak) UILabel *freshPriceLabel;

//选择按钮
@property (nonatomic, weak) UIButton *freshBtn;
//减号那妞
@property (nonatomic, weak) UIButton *minusBtn;
//显示已经购得的物品数
@property (nonatomic, weak) UILabel *numLabel;

@end

@implementation ANMFooterViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //添加控件,设置格式
        UIImageView *freshImageView = [UIImageView new];
        [self addSubview:freshImageView];
        self.freshImageView = freshImageView;
        
        UIButton * freshBtn =[UIButton new];
        [freshBtn setBackgroundImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
        [self addSubview:freshBtn];
        self.freshBtn = freshBtn;
        [freshBtn addTarget:self action:@selector(postNotification) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * minusBtn =[UIButton new];
        [minusBtn setBackgroundImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
        [self addSubview:minusBtn];
        self.minusBtn = minusBtn;
        [minusBtn addTarget:self action:@selector(minuspost) forControlEvents:UIControlEventTouchUpInside];
       
        
        UILabel *freshNameLabel = [UILabel new];
        [self addSubview:freshNameLabel];
        freshNameLabel.adjustsFontSizeToFitWidth = YES;
        self.freshNameLabel = freshNameLabel;
        
        UILabel *freshMaiLabel = [UILabel new];
        [self addSubview:freshMaiLabel];
        self.freshMaiLabel = freshMaiLabel;
        
        UILabel *freshNumLabel = [UILabel new];
        [self addSubview:freshNumLabel];
        self.freshNumLabel = freshNumLabel;
        
        UILabel *freshPriceLabel = [UILabel new];
        [self addSubview:freshPriceLabel];
        self.freshPriceLabel = freshPriceLabel;
        
        UILabel *numLabel = [UILabel new];
        [self addSubview:numLabel];
        self.numLabel = numLabel;
        numLabel.text = @"0";
        for (ANMFreshModel *freshModel in [ANMCartSingle sharedCart].freshModelArr) {
            if ([self.freshModel.name isEqualToString:freshModel.name]) {
                self.numLabel.text = [NSString stringWithFormat:@"%zd",freshModel.count + 1];
                
            }
        }
        
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置大小
    self.freshImageView.frame = CGRectMake(10, 10, self.bounds.size.width -20, self.bounds.size.width -20);
    self.freshNameLabel.frame = CGRectMake(0, self.bounds.size.width -20, self.bounds.size.width, 15);
    self.freshMaiLabel.frame = CGRectMake(0, self.bounds.size.width -5, self.bounds.size.width, 15);
    self.freshNumLabel.frame = CGRectMake(0, self.bounds.size.width +10, self.bounds.size.width, 15);
    self.freshPriceLabel.frame = CGRectMake(0, self.bounds.size.width +25, self.bounds.size.width, 15);
    self.freshBtn.frame = CGRectMake(self.bounds.size.width -30, self.bounds.size.height - 30, 25, 25);
    self.minusBtn.frame = CGRectMake(self.bounds.size.width - 75, self.bounds.size.height - 30, 25, 25);
    self.numLabel.frame = CGRectMake(self.bounds.size.width - 55,  self.bounds.size.height - 30, 20, 22);
    
}

-(void)setFreshModel:(ANMFreshModel *)freshModel{
    
//    for (ANMFreshModel *freshModel in [ANMCartSingle sharedCart].freshModelArr) {
//        if ([self.freshModel.name isEqualToString:freshModel.name]) {
//            self.numLabel.text = [NSString stringWithFormat:@"%zd",freshModel.count +1];
//            
//        }
//    }
    
    if (self.cellType == 0) {
        self.minusBtn.hidden = YES;
        self.numLabel.hidden = YES;
    }else{
        self.minusBtn.hidden = YES;
        self.numLabel.hidden = YES;
    }
    
    _freshModel = freshModel;
    // 设置内容
    [self.freshImageView sd_setImageWithURL:[NSURL URLWithString:freshModel.img]];
    self.freshNameLabel.text = freshModel.name;
    self.freshMaiLabel.text = freshModel.pm_desc;
    self.freshNumLabel.text = freshModel.specifics;
    self.freshPriceLabel.text = freshModel.price;
    
   
    
}

-(void)postNotification{
    for (ANMFreshModel *freshModel in [ANMCartSingle sharedCart].freshModelArr) {
        if ([self.freshModel.name isEqualToString:freshModel.name]) {
//            self.numLabel.text = [NSString stringWithFormat:@"%zd",freshModel.count + 1];
            if (freshModel.count + 1 >= 20) {
                [self showHUD:@"商品已达上限"];
                return;
                
            }
            
        }
    }
  
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"addToCartNotification" object:self.freshModel];
}

-(void)minuspost{
    NSLog(@"...");
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
