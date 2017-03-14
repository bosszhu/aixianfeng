//
//  ANMGoodDetailVc.m
//  ainimei
//
//  Created by kingLee on 16/11/18.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMGoodDetailVc.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "ANMCartSingle.h"
#import <SVProgressHUD.h>

#define screenHeight [UIScreen mainScreen].bounds.size.height

@interface ANMGoodDetailVc ()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIView *concentView;
//图片
@property (nonatomic, weak) UIImageView *bigImageView;
//名字
@property (nonatomic, weak) UILabel  *nameLabel;
//价格
@property (nonatomic, weak) UILabel *priceLabel;
//品牌信息
@property (nonatomic, weak) UILabel *brandLabel;
@property (nonatomic, weak) UILabel *brandName;
//规格信心
@property (nonatomic, weak) UILabel *guigeLabel;
@property (nonatomic, weak) UILabel *guigeName;
@property (nonatomic, weak) UILabel *discLabel;

//下部的购物条
@property (nonatomic, weak) UIView  *bottomView;
@property (nonatomic, weak) UILabel *addLabel;
//下部加减按钮和数量label,购物车
@property (nonatomic, weak) UIButton *minusBtn;
@property (nonatomic, weak) UIButton *plusBtn;
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UIButton *shopBtn;
@property (nonatomic, weak) UIButton *shopNumBtn;

@end

@implementation ANMGoodDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //布局外边的scrollview
    self.title = self.freshModel.name;
    [self setupScrollView];
    //布局撑起scollview的内部view
    [self setupContentView];
    //布局其他控件
    [self setupUI];
    [self makeConstrant];
    
}

-(void)setupScrollView{
    UIScrollView *scrollView = [UIScrollView new];
    self.scrollView = scrollView;
    [self.view addSubview:scrollView];
    //约束
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

-(void)setupContentView{
    UIView *contentView = [[UIView alloc]init];
    self.concentView = contentView;
    [self.scrollView addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width, 1000));
    }];
    
}
-(void)setupUI{
    UIImageView *bigImageView = [[UIImageView alloc]init];
    self.bigImageView = bigImageView;
    [self.concentView addSubview:bigImageView];
    bigImageView.backgroundColor = [UIColor greenColor];
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:self.freshModel.img]];
    
    UILabel *nameLabel = [UILabel new];
    self.nameLabel = nameLabel;
    [self.concentView addSubview:nameLabel];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.text = self.freshModel.name;
    
    UILabel *priceLabel = [UILabel new];
    self.priceLabel = priceLabel;
    [self.concentView addSubview:priceLabel];
    priceLabel.textAlignment = NSTextAlignmentLeft;
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.textColor = [UIColor redColor];
    self.priceLabel.text =[NSString stringWithFormat:@"$%@", self.freshModel.price];
    
    UILabel *brandLabel = [UILabel new];
    self.brandLabel = brandLabel;
    [self.concentView addSubview:brandLabel];
    brandLabel.textAlignment = NSTextAlignmentLeft;
    brandLabel.font = [UIFont systemFontOfSize:14];
    brandLabel.textColor = [UIColor lightGrayColor];
    brandLabel.text = @"品   牌";
    
    UILabel *brandName = [UILabel new];
    self.brandName = brandName;
    [self.concentView addSubview:brandName];
    brandName.textAlignment = NSTextAlignmentLeft;
    brandName.font = [UIFont systemFontOfSize:14];
//    brandName.textColor = [UIColor lightGrayColor];
    self.brandName.text =self.freshModel.brand_name;
    
    UILabel *guigeLabel = [UILabel new];
    self.guigeLabel = guigeLabel;
    [self.concentView addSubview:guigeLabel];
    guigeLabel.textAlignment = NSTextAlignmentLeft;
    guigeLabel.font = [UIFont systemFontOfSize:14];
    guigeLabel.textColor = [UIColor lightGrayColor];
    guigeLabel.text = @"产品规格";
    
    UILabel *guigeName = [UILabel new];
    self.guigeName = guigeName;
    [self.concentView addSubview:guigeName];
    guigeName.textAlignment = NSTextAlignmentLeft;
    guigeName.font = [UIFont systemFontOfSize:14];
    //    brandName.textColor = [UIColor lightGrayColor];
    self.guigeName.text = self.freshModel.specifics;
    
    UILabel *discLabel = [UILabel new];
    self.discLabel = discLabel;
    [self.concentView addSubview:discLabel];
    discLabel.textAlignment = NSTextAlignmentLeft;
    discLabel.font = [UIFont systemFontOfSize:14];
    discLabel.textColor = [UIColor lightGrayColor];
    discLabel.text = @"图文详情";
    
    UIView *bottomView = [UIView new];
    self.bottomView = bottomView;
    bottomView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:bottomView];
    
    UILabel *addLabel = [UILabel new];
    self.addLabel = addLabel;
    [self.bottomView addSubview:addLabel];
    addLabel.textAlignment = NSTextAlignmentLeft;
    addLabel.font = [UIFont systemFontOfSize:14];
//    discLabel.textColor = [UIColor lightGrayColor];
    addLabel.text = @"添加商品:";
    
    UIButton *minusBtn = [UIButton new];
    [minusBtn setBackgroundImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
    self.minusBtn = minusBtn;
    [self.bottomView addSubview:minusBtn];
    [minusBtn addTarget:self action:@selector(minusDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *numLabel = [UILabel new];
    self.numLabel = numLabel;
    [self.bottomView addSubview:numLabel];
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.font = [UIFont systemFontOfSize:14];
    //    brandName.textColor = [UIColor lightGrayColor];
    // 计算购物车里有没有重复
    numLabel.text = @"0";
    for (ANMFreshModel *freshModel in [ANMCartSingle sharedCart].freshModelArr) {
        if ([self.freshModel.name isEqualToString:freshModel.name]) {
            numLabel.text = [NSString stringWithFormat:@"%zd",freshModel.count +1];
        }
    }
    
    
    UIButton *plusBtn = [UIButton new];
    [plusBtn setBackgroundImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
    self.plusBtn = plusBtn;
    [self.bottomView addSubview:plusBtn];
    [plusBtn addTarget:self action:@selector(plusDidClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *shopBtn = [UIButton new];
    [shopBtn setBackgroundImage:[UIImage imageNamed:@"v2_shopEmpty"] forState:UIControlStateNormal];
    [shopBtn setImage:[UIImage imageNamed:@"v2_whiteShopBig"] forState:UIControlStateNormal];
    self.shopBtn = shopBtn;
    [self.bottomView addSubview:shopBtn];
    [shopBtn addTarget:self action:@selector(jumpToCart) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shopNumBtn = [UIButton new];
    [shopNumBtn setBackgroundImage:[UIImage imageNamed:@"reddot"] forState:UIControlStateNormal];
    //计算购物车里原来有的物品数量
    NSUInteger sum = [ANMCartSingle sharedCart].count;
    [shopNumBtn setTitle:[NSString stringWithFormat:@"%zd",sum] forState:UIControlStateNormal];
    shopNumBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [shopNumBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    shopNumBtn.enabled = NO;
    self.shopNumBtn = shopNumBtn;
    [self.bottomView addSubview:shopNumBtn];
    
    
}

-(void)makeConstrant{
    [self.bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self.concentView);
        make.height.mas_equalTo(screenHeight *0.5);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.concentView).offset(15);
        make.top.mas_equalTo(self.bigImageView.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.concentView).offset(15);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [self.brandLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.concentView).offset(15);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [self.brandName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.brandLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.priceLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [self.guigeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.concentView).offset(15);
        make.top.mas_equalTo(self.brandLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [self.guigeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.guigeLabel.mas_right).offset(10);
        make.top.mas_equalTo(self.brandLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(150, 30));
    }];
    
    [self.discLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.concentView).offset(15);
        make.top.mas_equalTo(self.guigeLabel.mas_bottom).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 30));
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    [self.addLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bottomView).offset(15);
        make.size.mas_equalTo(CGSizeMake(70, 30));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.minusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.addLabel.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.minusBtn.mas_right).offset(3);
        make.centerY.mas_equalTo(self.bottomView);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [self.plusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.numLabel.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(self.bottomView);
    }];
    
    [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView).offset(-10);
        make.bottom.mas_equalTo(self.bottomView).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [self.shopNumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomView).offset(-5);
        make.bottom.mas_equalTo(self.bottomView).offset(-40);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
}

-(void)setFreshModel:(ANMFreshModel *)freshModel{
    _freshModel = freshModel;
}

#pragma mark - 响应事件
-(void)minusDidClicked{
    //更新界面数字//更新购物车数字//更新购物车单例
    [[ANMCartSingle sharedCart]removeFreshModelArrObject:self.freshModel];
    if (self.numLabel.text.integerValue >0) {
         self.numLabel.text = [NSString stringWithFormat:@"%zd",self.numLabel.text.integerValue - 1];
    }
    NSUInteger sum = [ANMCartSingle sharedCart].count;
    [self.shopNumBtn setTitle:[NSString stringWithFormat:@"%zd",sum] forState:UIControlStateNormal];

}
-(void)plusDidClicked{
    //同上
//    NSLog(@"%@",[ANMCartSingle sharedCart].freshModelArr);
    //这里有bug
    if (self.numLabel.text.integerValue >= 20) {
        [self showHUD:@"商品已达上限"];
        return;
        
    }
    [[ANMCartSingle sharedCart] addFreshModelArrObject: self.freshModel];
    self.numLabel.text = [NSString stringWithFormat:@"%zd",self.numLabel.text.integerValue + 1];
    NSUInteger sum = [ANMCartSingle sharedCart].count;
    [self.shopNumBtn setTitle:[NSString stringWithFormat:@"%zd",sum] forState:UIControlStateNormal];
}

-(void)jumpToCart{
    //更新角标
    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
    item.badgeValue = [NSString stringWithFormat:@"%zd",[ANMCartSingle sharedCart].count];
    
    self.tabBarController.selectedIndex = 2;
    [self.navigationController setViewControllers:@[self.navigationController.childViewControllers[0]]];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
    item.badgeValue = [NSString stringWithFormat:@"%zd",[ANMCartSingle sharedCart].count];
    if ([ANMCartSingle sharedCart].count== 0) {
        item.badgeValue = nil;
    }
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
