//
//  ANMOrderDetailVc.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderDetailVc.h"
#import "ANMOrderStatusCell.h"
#import "ANMOrderDetailCell.h"
#import "ANMOrderDetailFirstCell.h"
#import "ANMOrderDetailSecondCell.h"
#import "ANMOrderDetailThirdCell.h"
#import "ANMOrderDetailLastCell.h"

@interface ANMOrderDetailVc ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *statusTableView;
@property (nonatomic, weak) UITableView *detailTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ANMOrderDetailVc

static NSString *cellStatusID = @"statusCell";
static NSString *cellDetailID = @"DetailCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"订单详情";
    //加载tableView
    [self setupDetailTableView];
    [self setupStatusTableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSegement];
    self.statusTableView.hidden = YES;
    self.detailTableView.hidden = NO;
    
    [self.view bringSubviewToFront:self.bottomView];
    
}



#pragma mark -  设置分栏
-(void)setupSegement{
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"订单状态",@"订单详情"]];
    [segment setWidth:80 forSegmentAtIndex:0];
    [segment setWidth:80 forSegmentAtIndex:1];
    
    segment.selectedSegmentIndex = 1;
    self.navigationItem.titleView = segment;
    [segment setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_normal"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [segment setBackgroundImage:[UIImage imageNamed:@"white"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [segment setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName:[UIColor lightGrayColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:15]
                                      } forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName:[UIColor blackColor],
                                      NSFontAttributeName:[UIFont systemFontOfSize:15]
                                      } forState:UIControlStateSelected];
    [segment setFrame:CGRectMake(0, 0, 160, 30)];
    [segment setTintColor:[UIColor colorWithRed:0.99 green:0.87 blue:0.42 alpha:1.00]];
    segment.layer.cornerRadius = 5;
    segment.clipsToBounds = YES;
    
    [segment addTarget:self action:@selector(didClickSeg:) forControlEvents:UIControlEventValueChanged];
    
}

-(void)didClickSeg:(UISegmentedControl *)sender{
    
    
    if (sender.selectedSegmentIndex == 0) {
        self.statusTableView.hidden = NO;
        self.detailTableView.hidden = YES;
    }else{
        self.statusTableView.hidden = YES;
        self.detailTableView.hidden = NO;
    }
}

#pragma mark - 初始化statusTableView
-(void)setupStatusTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-45) style:UITableViewStylePlain];
    self.statusTableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[ANMOrderStatusCell class] forCellReuseIdentifier:cellStatusID];
    [self.view addSubview:tableView];
}

-(void)setupDetailTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-45) style:UITableViewStylePlain];
    self.detailTableView= tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[ANMOrderDetailCell class] forCellReuseIdentifier:cellDetailID];
    [self.view addSubview:tableView];
}


#pragma mark - tableview代理及数据源,设置cell
//数目相关
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.statusTableView) {
        return 1;
    }else{
        return 4;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.statusTableView) {
        return 5;
    }else{
        if (section ==2) {
            return self.orderModel.order_goods.count + 2;
        }else{
            return 1;
        }
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.statusTableView) {
        ANMOrderStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatusID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[ANMOrderStatusCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStatusID];
        }
        cell.timeline = self.orderModel.timelines[indexPath.row];
        if (indexPath.row == 0) {
            cell.iconView.image = [UIImage imageNamed:@"order_yellowMark"];
            cell.upView.hidden = YES;
            cell.statusLabel.textColor = [UIColor blackColor];
        }
        if (indexPath.row == 4) {
            cell.lowerView.hidden = YES;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        if(indexPath.section == 0){
            ANMOrderDetailFirstCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailFirstCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.orderModel = self.orderModel;
            return cell;
        }else if(indexPath.section == 1){
            ANMOrderDetailSecondCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailSecondCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.orderModel = self.orderModel;
            return cell;
        }else if(indexPath.section == 2){
            if (indexPath.row == 0) {
                UITableViewCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailMiddleCell" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else if(indexPath.row == self.orderModel.order_goods.count +1){
                ANMOrderDetailThirdCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailThirdCell" owner:nil options:nil]lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.orderModel = self.orderModel;
                return cell;
            }else{
                
                ANMOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetailID forIndexPath:indexPath];
                if (cell == nil) {
                    cell = [[ANMOrderDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetailID];
                }
                cell.goodsModel = self.orderModel.order_goods[indexPath.row-1];
                return cell;
            }
        }else{
            ANMOrderDetailLastCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"OrderDetailLastCell" owner:nil options:nil]lastObject];
            cell.orderModel = self.orderModel;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
        
        
    }
}

// 设置高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.statusTableView) {
        return 70;
    }else{
        if (indexPath.section ==0) {
            return 180;
        }else if(indexPath.section == 1){
            return 80;
        }else if(indexPath.section ==3){
            return 85;
        }else{
            if (indexPath.row ==self.orderModel.order_goods.count +1) {
                return 120;
            }else{
                return 40;
            }
        }
    }
}

#pragma mark - 设置tableview底部
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView == self.statusTableView) {
        return nil;
    }else{
        UIView *BackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 10)];
        BackView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
        return BackView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.statusTableView) {
        return 0;
    }else{
        return 10;
    }
}


@end
