//
//  ANMFlashMarketViewController.m
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFlashMarketViewController.h"
#import "DSHTTPClient.h"
#import "Masonry.h"
#import "ANMRightViewController.h"
#import "ANMLeftTableViewCell.h"
#import "ANMFlsahMarketSource.h"
#import "YYModel.h"
#import "ANMCartSingle.h"
#import "SVProgressHUD.h"

#define WEAKSELf __weak typeof(self) weakSelf = self;


@interface ANMFlashMarketViewController ()<UITableViewDelegate,UITableViewDataSource,ProductsDelegate>

@property (nonatomic,strong) SuperMarketData * superMarketData;

//左边的导航
@property (nonatomic,strong) UITableView * categoriesTableView;
//右边的uiview控制器
@property (nonatomic,strong) ANMRightViewController *productsController;

@end

@implementation ANMFlashMarketViewController

- (void)viewDidLoad {
        [super viewDidLoad];
//    self.view.backgroundColor = [UIColor colorWithRed:253/255.0 green:212/255.0 blue:49/255.0 alpha:1.0];
//    self.view.backgroundColor = [UIColor whiteColor];
    [self setUpProductsTableView];
    [self setUpcategoriesTableView];
    [SVProgressHUD showWithStatus:@"正在加载，请稍后"];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(minusSelf:) name:@"minusFromMarket" object:nil];
    
}

//监听数据的减少
-(void)minusSelf:(NSNotification *)no{
    [[ANMCartSingle sharedCart]removeFreshModelArrObject:no.object];
    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
    item.badgeValue = [NSString stringWithFormat:@"%zd",[ANMCartSingle sharedCart].count];
    if ([ANMCartSingle sharedCart].count == 0) {
       
        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
        item.badgeValue = nil;

    }
    [self loadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
    
    [self performSelector:@selector(dismiss:) withObject:nil afterDelay:2];
}
- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}

-(void)loadData
{
    
    [ANMFlsahMarketSource loadSupermarketData:^(id data, NSError *error) {
        
        self.superMarketData = data;
        [self.categoriesTableView reloadData];
        [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        self.productsController.superMarketData =data;
    }];
}

    
    

-(void)setUpcategoriesTableView
{
    self.categoriesTableView = ({
        UITableView *tabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
//       
        tabView.delegate = self;
        tabView.dataSource = self;
        tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tabView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        tabView.showsVerticalScrollIndicator = NO;
        tabView;
    });
    [self.view addSubview:self.categoriesTableView];
    [self.categoriesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.leading.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(self.view).multipliedBy(0.25);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.superMarketData.categories.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ANMLeftTableViewCell *cell = [ANMLeftTableViewCell cellWith:tableView];
    cell.categroies = self.superMarketData.categories[indexPath.row];
    return cell;

   
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark - 右边控制器
-(void)setUpProductsTableView
{
    self.productsController = [[ANMRightViewController alloc]init];
    
    [self addChildViewController:self.productsController];
    [self.view addSubview:self.productsController.view];
    self.delegate = self.productsController;
    self.productsController.delegate =self;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(didTableView:clickedAtIndexPath:)]) {
        [self.delegate didTableView:self.categoriesTableView clickedAtIndexPath:indexPath];
    }
//    UIView *yellow = [UIView new];
//    self
//    [yellow mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.leading.equalTo(self);
//        make.top.equalTo(self).offset(5);
//        make.bottom.equalTo(self).offset(-5);
//        make.width.mas_equalTo(5);
//    }];
    
//    [self.categoriesTableView reloadData];
}
#pragma mark  ProductsDelegate

//- (void)willDislayHeaderView:(NSInteger)section
//{
//    [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//}
//- (void)didEndDislayHeaderView:(NSInteger)section
//{
//    [self.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section+1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//}

@end
