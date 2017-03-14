//
//  MyOrderViewController.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "MyOrderViewController.h"
#import "DSHTTPClient.h"
#import <YYModel.h>
#import "ANMMyOrderModel.h"
#import "ANMGoodsModel.h"
#import "ANMOrderCell.h"
#import "ANMOrderDetailVc.h"

@interface MyOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray<ANMMyOrderModel *> *orderModelArr;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation MyOrderViewController

static NSString *cellID = @"orderCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置头部标题
    self.navigationItem.title = @"我的订单";
    //先布局控件
    [self setupTableView];
    //请求订单数据,用网络
    [self requsetOrder];
    
}

//懒加载模型数组
-(NSMutableArray<ANMMyOrderModel *> *)orderModelArr{
    if (_orderModelArr == nil) {
        _orderModelArr = [NSMutableArray new];
    }
    return _orderModelArr;
}

//发送网络请求
- (void)requsetOrder{
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"13" forKey:@"call"];
    
    [DSHTTPClient postUrlString:@"MyOrders.json.php" withParam:param withSuccessBlock:^(id data) {
       //字典转模型
        NSMutableArray *newArr = [NSMutableArray new];
        NSArray * dataArr = data[@"data"];
        for (NSDictionary *modelDic in dataArr) {
            ANMMyOrderModel *model = [ANMMyOrderModel orderModelWithDict:modelDic];
            [newArr addObject:model];
        }
        self.orderModelArr = newArr;
        [self.tableView reloadData];
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}

#pragma mark - 创建tabelview
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[ANMOrderCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    
}

#pragma mark - tableview数据展示

//设置数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.orderModelArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 85;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


//设置内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ANMOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ANMOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.goodsArr = self.orderModelArr[indexPath.section].order_goods;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    //添加时间
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 180, 20)];
    headerLabel.font = [UIFont systemFontOfSize:14];
    headerLabel.text = self.orderModelArr[section].pay_time;
    [headerView addSubview:headerLabel];
    //添加完成状态
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 95, 5, 80, 20)];
    statusLabel.textAlignment = NSTextAlignmentRight;
    statusLabel.font = [UIFont systemFontOfSize:14];
    statusLabel.text = @"已完成";
    statusLabel.textColor = [UIColor redColor];
    [headerView addSubview:statusLabel];
    
    return headerView;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    footerView.backgroundColor = [UIColor whiteColor];
    //添加商品总件数
    UILabel *footerLabel =[[UILabel alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 195, 5, 180, 20)];
    footerLabel.font = [UIFont systemFontOfSize:14];
    footerLabel.textAlignment = NSTextAlignmentRight;
    footerLabel.textColor = [UIColor lightGrayColor];
    footerLabel.text =[NSString stringWithFormat:@"共%zd件商品    实付:$%@", self.orderModelArr[section].myCount,self.orderModelArr[section].real_amount];
    [footerView addSubview:footerLabel];
    //添加发福利
    UIButton *fuliBtn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 70, 30, 55, 23)];
    fuliBtn.layer.cornerRadius = 5;
    fuliBtn.layer.masksToBounds = YES;
    fuliBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [fuliBtn setBackgroundColor:[UIColor colorWithRed:0.99 green:0.83 blue:0.19 alpha:1.00]];
    [fuliBtn setTitle:self.orderModelArr[section].myFirstName forState:UIControlStateNormal];
    [fuliBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerView addSubview:fuliBtn];
    
    //添加背景色view
    UIView *BackView = [[UIView alloc]initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, 25)];
    BackView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [footerView addSubview:BackView];
    
    return footerView;
}

#pragma mark - 跳转事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //实例化订单详情,并传递数据给它的属性,用set方法显示数据
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"OrderDetail" bundle:nil];
    ANMOrderDetailVc *vc = [sb instantiateInitialViewController];
    vc.orderModel = self.orderModelArr[indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
