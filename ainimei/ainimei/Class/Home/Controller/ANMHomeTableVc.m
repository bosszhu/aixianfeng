//
//  ANMHomeTableVc.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMHomeTableVc.h"
#import "DSHTTPClient.h"
#import "ANMTopModel.h"
#import "ANMBtnModel.h"
#import "ANMActivityModel.h"
#import "ANMTopVc.h"
#import "ANMActivityCell.h"
#import "ANMFooterView.h"
#import "ANMFreshModel.h"
#import "ANMCartSingle.h"
#import "UINavigationBar+Awesome.h"
#import "ANMQRCodeViewController.h"

#import "ANMLookFor.h"
#import "ANMWebVc.h"
#import "ANMRefreshHeader.h"
#import "ANMAdress.h"


//记录什么时候导航条开始渐变
#define NAVBAR_CHANGE_POINT 25

@interface ANMHomeTableVc ()

//用于存放顶部轮播器模型的数组
@property (nonatomic, strong) NSArray<ANMTopModel *> *topModelArr;

//用于存放导航按钮模型的数组
@property (nonatomic, strong) NSArray<ANMBtnModel *> *btnModelArr;

//用于存放活动cell模型的数组
@property (nonatomic, strong) NSArray<ANMActivityModel *> *actModelArr;

//用于存放热卖的模型数组
@property (nonatomic, strong) NSArray<ANMFreshModel *> *freshModelArr;

//引用collectionView
@property (nonatomic, weak) ANMFooterView *footerView;

//控制导航按钮的变色
@property (nonatomic, weak) UIButton *navBtn;

@end

//管理首页的tableVc
@implementation ANMHomeTableVc
static NSString * cellID = @"mycell";

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupNavBtn];

    
    

    
    //注册cell
    [self.tableView registerClass:[ANMActivityCell class] forCellReuseIdentifier:cellID];
    //设置行高
    self.tableView.rowHeight = 150;
    //设置间距为隐藏
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self focus];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.tableView.frame = CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height);
    
    //初始化购物车单例,显示tabbar的数字
    ANMCartSingle *cart = [ANMCartSingle sharedCart];
    if (cart.freshModelArr.count == 0) {
        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
        item.badgeValue = nil;
    }else{
        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
        item.badgeValue = [NSString stringWithFormat:@"%zd",cart.freshModelArr.count + 1];
    }
    
    // 设置footerview为collectionview,负责展示流cell
    ANMFooterView *footerView = [[ANMFooterView alloc]init];
//    footerView.requestUrl = @"firstSell.json.php";
//    footerView.callNum = @"2";
    footerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 4000);
//    footerView.backgroundColor = [UIColor yellowColor];
    self.tableView.tableFooterView = footerView;
    
    //因为此控制器一开始就存活,可以负责监听
    //监听有加入购物车通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(addGoods:) name:@"addToCartNotification" object:nil];
    
    //添加明杰刷新
    ANMRefreshHeader * header =[ANMRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerFresh)];
    
    self.tableView.mj_header = header;
    
}
//明杰刷新
-(void)headerFresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}

//更新单例数据,更新tabar数字.
-(void)addGoods:(NSNotification *)no{
    ANMCartSingle *cart = [ANMCartSingle sharedCart];
    [cart addFreshModelArrObject: no.object];
    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
    item.badgeValue = [NSString stringWithFormat:@"%zd",cart.count];

}


//请求首页上部的数据
- (void)focus{
    //请求首页轮播器,图标,促销cell的图片及跳转数据
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"1" forKey:@"call"];
    
    
    [DSHTTPClient postUrlString:@"focus.json.php" withParam:param withSuccessBlock:^(id data) {
        //字典转模型
        NSDictionary *dataDict = data[@"data"];
        
        //处理轮播器模型
        NSArray *focusArr = dataDict[@"focus"];
        NSMutableArray *mArr = [NSMutableArray new];
        for (NSDictionary *focusDic in focusArr) {
            ANMTopModel *topModel = [ANMTopModel topModelWihtDict:focusDic];
            [mArr addObject:topModel];
        }
        self.topModelArr = mArr;
        
        
        //处理按钮模型
        NSArray *iconsArr = dataDict[@"icons"];
        NSMutableArray *mArrTwo = [NSMutableArray new];
        for (NSDictionary *iconsDic  in iconsArr) {
            ANMBtnModel *btnModel = [ANMBtnModel btnModelWithDict:iconsDic];
            [mArrTwo addObject:btnModel];
        }
        self.btnModelArr = mArrTwo;
        
        //传递模型数组给轮播视图控制器
        ANMTopVc *topVc = (ANMTopVc *) self.childViewControllers.firstObject;
        topVc.topModelArr = self.topModelArr;
        topVc.btnModelArr = self.btnModelArr;
        
        //处理cell活动模型
        NSArray *activitiesArr = dataDict[@"activities"];
        NSMutableArray *mArrThree = [NSMutableArray new];
        for (NSDictionary *actDic  in activitiesArr) {
            ANMActivityModel *actModel = [ANMActivityModel activityModelWithDict:actDic];
            [mArrThree addObject:actModel];
        }
        self.actModelArr = mArrThree;
        [self.tableView reloadData];
        
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
    
}



#pragma mark - Table view data source
//懒加载
-(NSArray<ANMActivityModel *> *)actModelArr{
    if (_actModelArr == nil) {
        _actModelArr = [NSArray new];
    }
    return _actModelArr;
}
//懒加载
-(NSArray<ANMFreshModel *> *)freshModelArr{
    if (_freshModelArr == nil) {
        _freshModelArr = [NSArray new];
    }
    return _freshModelArr;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.actModelArr.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ANMActivityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ANMActivityCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.00];
    cell.actModel = self.actModelArr[indexPath.row];
    
    return cell;
}

#pragma mark - 导航条相关
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:1.00 green:0.84 blue:0.19 alpha:1.00];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
        [self.navBtn setBackgroundColor:[UIColor clearColor]];
        [self.navBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
        [self.navBtn setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        [self.navBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tableView.delegate = self;
//    [self focus];
    [self scrollViewDidScroll:self.tableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableView.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    
}

#pragma mark - 设置导航条按钮及点击事件跳转
-(void)setupNavBtn{
    //导航条最开始透明
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    
    //设置顶部button
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
    btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.cornerRadius = 10;
//    btn.titleLabel.attributedText = [self changeLabelWithText:@"配送至: 中粮商务公园"];
    [btn setTitle:@"配送至: 中粮商务公园" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor whiteColor]];
    btn.layer.masksToBounds = YES;
    self.navigationItem.titleView = btn;
    [btn addTarget:self action:@selector(jumpToAdress) forControlEvents:UIControlEventTouchUpInside];
    self.navBtn = btn;
    
    //设置左侧btn
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icon_black_scancode"] forState:UIControlStateNormal];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    [leftBtn addTarget:self action:@selector(jumpToSao) forControlEvents:UIControlEventTouchUpInside];
    
    //设置右侧btn
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_search"] forState:UIControlStateNormal];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    [rightBtn addTarget:self action:@selector(jumpToSearch) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)jumpToAdress{
    ANMAdress *v = [ANMAdress new];
    [self.navigationController pushViewController:v animated:YES];
    
}

-(void)jumpToSao{
    ANMQRCodeViewController *vc =  [ANMQRCodeViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)jumpToSearch{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ANMLookFor" bundle:nil];
    ANMLookFor *newVc = [sb instantiateInitialViewController];
    [self.navigationController pushViewController:newVc animated:YES];
}

#pragma mark - 设置cell的活动跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ANMWebVc *webView = [ANMWebVc new];
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.urlStr = self.actModelArr[indexPath.row].customURL;
    [self.navigationController pushViewController:webView animated:YES];
}


@end
