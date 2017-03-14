//
//  ANMLookDetail.m
//  ainimei
//
//  Created by kingLee on 16/11/18.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMLookDetail.h"
#import "ANMLookForCollectionView.h"
#import <Masonry.h>

@interface ANMLookDetail()
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) ANMLookForCollectionView * myView;
@property (nonatomic, weak) UIView *contentView;
@end

@interface ANMLookDetail ()

@end

@implementation ANMLookDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupScrollView];
    [self setupContentView];
    [self setupDetailView];
    
    //添加顶部搜索条
    UISearchBar *bar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 180, 25)];
    bar.text= _textString;
    self.navigationItem.titleView = bar;
    
    UIView *backYellowView = [UIView new];
    backYellowView.backgroundColor = [UIColor colorWithRed:0.97 green:0.95 blue:0.84 alpha:1.00];
    [self.contentView addSubview:backYellowView];
    [backYellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(60);
    }];
    
    UIImageView *gantanImageView = [UIImageView new];
    gantanImageView.image = [UIImage imageNamed:@"notsupporttakeself"];
    [backYellowView addSubview:gantanImageView];
    
    [gantanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(backYellowView).offset(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *maiLabel = [UILabel new];
    [backYellowView addSubview:maiLabel];
    maiLabel.textColor = [UIColor colorWithRed:0.69 green:0.57 blue:0.47 alpha:1.00];
    maiLabel.text = [NSString stringWithFormat:@"暂时没有搜到\"%@\"相关商品",_textString];
    maiLabel.font = [UIFont systemFontOfSize:15];
    [maiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gantanImageView.mas_right).offset(10);
        make.top.mas_equalTo(backYellowView).offset(15);
        make.size.mas_equalTo(CGSizeMake(270, 20));
    }];
    
    UILabel *discLabel = [UILabel new];
    [backYellowView addSubview:discLabel];
    discLabel.textColor = [UIColor colorWithRed:0.98 green:0.84 blue:0.55 alpha:1.00];
    discLabel.text = @"换其他关键词试试看,但是并没有什么卵用";
    discLabel.font = [UIFont systemFontOfSize:13];
    [discLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(gantanImageView.mas_right).offset(10);
        make.top.mas_equalTo(maiLabel.mas_bottom).offset(5);
        make.size.mas_equalTo(CGSizeMake(270, 20));
    }];
    
    UILabel *tipLabel = [UILabel new];
    [self.contentView addSubview:tipLabel];
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.text = @"大家都在买";
    tipLabel.font = [UIFont systemFontOfSize:13];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(10);
        make.top.mas_equalTo(backYellowView.mas_bottom).offset(25);
        make.size.mas_equalTo(CGSizeMake(180, 20));
    }];
    
    
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
    self.contentView = contentView;
    [self.scrollView addSubview:contentView];
    contentView.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.size.mas_equalTo(CGSizeMake([UIScreen mainScreen].bounds.size.width,3600));
    }];
    
}

-(void)setupDetailView{
    ANMLookForCollectionView *myView = [ANMLookForCollectionView new];
    [self.contentView addSubview:myView];
    
    [myView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView).offset(100);
        make.height.mas_equalTo(3600);
    }];
}



@end
