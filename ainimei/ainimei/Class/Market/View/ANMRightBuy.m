//
//  ANMRightBuy.m
//  ainimei
//
//  Created by Huster on 2016/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMRightBuy.h"
#import "Masonry.h"
#import <SVProgressHUD.h>

@interface ANMRightBuy ()
/** 加号按钮 */
@property (nonatomic,strong) UIButton *addGoodsButton;
/** 减号按钮 */
@property (nonatomic,strong) UIButton *reduceGoodsButton;
/** 数量label */
@property (nonatomic,strong) UILabel *countLabel;
/** 购买商品的数量  */
@property (nonatomic,assign) NSInteger buyNumber;
@property (nonatomic,strong)UIView *cartAnimView;
@end
@implementation ANMRightBuy
- (instancetype)init{
    if (self= [super init]) {
        //加号按钮
        _addGoodsButton = [[UIButton alloc]init];
        [_addGoodsButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
        [_addGoodsButton addTarget:self action:@selector(addButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_addGoodsButton];
        
        _countLabel = [[UILabel alloc]init];
        _countLabel.text = @"0";
        _countLabel.font = [UIFont systemFontOfSize:14];
        _countLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_countLabel];
        
        _reduceGoodsButton = [[UIButton alloc]init];
        [_reduceGoodsButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
        [_reduceGoodsButton addTarget:self action:@selector(reduceButtonCliked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_reduceGoodsButton];
        
        [_reduceGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(self.mas_height);
        }];
        
        [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_reduceGoodsButton.mas_trailing).offset(3);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.trailing.equalTo(_addGoodsButton.mas_leading).offset(-2);
        }];
        [_addGoodsButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
            make.width.mas_equalTo(self.mas_height);
        }];
        
        
    }
    return self;
}

-(void)setGoodNum:(NSInteger)goodNum
{
    _goodNum = goodNum;
    self.buyNumber = goodNum;
   
}
-(void)setBuyNumber:(NSInteger)buyNumber
{
    _buyNumber = buyNumber;
    if (buyNumber == 0)
    {
        self.reduceGoodsButton.hidden = YES;
        self.countLabel.hidden = YES ;
    }else
    {
        self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)buyNumber];
        self.reduceGoodsButton.hidden = NO;
        self.countLabel.hidden = NO;
    }
}

-(void)addButtonCliked:(UIButton*)btn
{
    
    if (self.countLabel.text.integerValue >=20) {
        [self showHUD:@"商品已打上限"];
        return;
    }
    self.buyNumber++;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.buyNumber];
    
    //做判断
    
    _cartAnimView=[[UIImageView alloc] initWithFrame:CGRectMake(_myImage.frame.origin.x,self.myImage.frame.origin.y, _myImage.frame.size.width, _myImage.frame.size.height)];
    
    _cartAnimView.layer.masksToBounds = YES;
    _cartAnimView.layer.cornerRadius = _cartAnimView.frame.size.width *0.5;
    
    [self.superview addSubview:_cartAnimView];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 10.0 ];
    rotationAnimation.duration = 1.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = 0;
    
    //这个是让旋转动画慢于缩放动画执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_cartAnimView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    });
    
    [UIView animateWithDuration:1.0 animations:^{
//        _cartAnimView.frame=CGRectMake([UIScreen mainScreen].bounds.size.width-55, -([UIScreen mainScreen].bounds.size.height - self.bounds.size.height - 40), 0, 0);
        _cartAnimView.frame=CGRectMake(375,700,0,0);
    } completion:^(BOOL finished) {
        //动画完成后做的事
    }];
    
    //发送通知增加商品
     [[NSNotificationCenter defaultCenter]postNotificationName:@"addToCartNotification" object:self.freshModel];

}
-(void)reduceButtonCliked:(UIButton*)btn
{
    if (self.buyNumber<=0)
    {
        return;
    }
    
    self.buyNumber--;
    self.countLabel.text = [NSString stringWithFormat:@"%ld",(long)self.buyNumber];
    //发送减少物品的通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"minusFromMarket" object:[self newModelFromOld:self.freshModel] userInfo:nil];
    
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
