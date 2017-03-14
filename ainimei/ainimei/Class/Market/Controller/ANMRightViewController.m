//
//  ANMRightViewController.m
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMRightViewController.h"
#import "Masonry.h"
#import "ANMRightTableViewCell.h"
#import "ANMRefreshHeader.h"
#import "ANMHeadView.h"
#import "ANMGoodDetailVc.h"
#define LSCREENW  [[UIScreen mainScreen] bounds].size.width
#define LSCREENH [[UIScreen mainScreen] bounds].size.height

@interface ANMRightViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView * productsTableView;
//判断是否从下往上滑
@property (nonatomic) BOOL isScrollDown;
//记录上次滑动位置
@property (nonatomic) CGFloat lastOffsetY;

@end

@implementation ANMRightViewController
-(void)loadView
{
    self.view = [[UIView alloc]initWithFrame:CGRectMake(LSCREENW * 0.25, 0, LSCREENW * 0.75, LSCREENH - 64)];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setUpProductsTableView];
}

#pragma mark - 添加右边tablew
-(void)setUpProductsTableView
{
    self.productsTableView = ({
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        tabView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
    [self.view addSubview:self.productsTableView];
    [self.productsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    ANMRefreshHeader * header =[ANMRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];
    self.productsTableView.mj_header  = header;
    
    
    

}
-(void)headerFresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.productsTableView.mj_header endRefreshing];
    });
}
//返回每行行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.superMarketData.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    NSLog(@"当前的数量%zd",self.superMarketData.categories[section].products.count);
    
     return self.superMarketData.categories[section].products.count;
    
    
}
//返回右边头部标题行高
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
//右边头部标题
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ANMHeadView * head =[ANMHeadView headerCellWith:tableView];
    head.title =self.superMarketData.categories[section].name ;
    return head;
}
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (!self.isScrollDown && [self.delegate respondsToSelector:@selector(willDislayHeaderView:)])
    {
        [self.delegate willDislayHeaderView:section];
    }
}
-(void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.isScrollDown && [self.delegate respondsToSelector:@selector(didEndDislayHeaderView:)])
    {
        [self.delegate didEndDislayHeaderView:section];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ANMRightTableViewCell *cell = [ANMRightTableViewCell creatRightCellWith:tableView];

    cell.foods = self.superMarketData.categories[indexPath.section].products[indexPath.row];
    return cell;
    
}
#pragma scorllView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.isScrollDown = self.lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
    
}

#pragma mark CategoryTableViewDelagate
- (void)didTableView:(UITableView *)tableView clickedAtIndexPath:(NSIndexPath*)indexPath;
{
    [self.productsTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
- (void)setSuperMarketData:(SuperMarketData *)superMarketData {
    _superMarketData = superMarketData;
    [self.productsTableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ANMGoodDetailVc *detailVc = [ANMGoodDetailVc new];
    //使用方法：
    detailVc.freshModel = self.superMarketData.categories[indexPath.section].products[indexPath.row];
    [self.navigationController pushViewController:detailVc animated:YES];
    
}


@end
