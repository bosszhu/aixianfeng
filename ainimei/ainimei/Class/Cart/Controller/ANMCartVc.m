//
//  ANMCartVc.m
//  ainimei
//
//  Created by kingLee on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMCartVc.h"
#import "ANMFreshModel.h"
#import "ANMCartSingle.h"
#import "ANMProductCell.h"
#import "DetailAddressTableViewController.h"
#import "AddressModel.h"
#import "ANMPayAdressCell.h"

@interface ANMCartVc ()<UITableViewDelegate,UITableViewDataSource>
//购物车为空的背景
@property (weak, nonatomic) IBOutlet UIView *EmptyView;
//物品列表
@property (nonatomic, weak) UITableView *tableView;
//价格视图
@property (weak, nonatomic) IBOutlet UIView *PriceView;

//价格标签
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//记录地址model
@property (nonatomic, strong) AddressModel *addressModel;



@end

@implementation ANMCartVc
 static NSString *cellID = @"CartCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    //对tableView初始化,如果购物车有物品
    [self setupTableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateSelf:) name:@"addToCartInCart" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(minusSelf:) name:@"minusFromCart" object:nil];
    //设置滚动失焦
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// 懒加载addressModel
-(AddressModel *)addressModel{
    if (_addressModel == nil) {
        _addressModel = [AddressModel new];
        _addressModel.accept_name = @"维尼的小熊";
        _addressModel.gender = @"1";
        _addressModel.telphone = @"18833331111";
        _addressModel.address = @"人民大会堂 9527办公室";
        _addressModel.city_name = @"北京市";
    }
    return _addressModel;
}

//在即将出现时判断,并做初始化
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //读取购物车单例判断有没有数据
    ANMCartSingle *cart = [ANMCartSingle sharedCart];
    if (cart.freshModelArr.count == 0) {
        self.tableView.hidden = YES;
        self.PriceView.hidden = YES;
        self.EmptyView.hidden = NO;
    }else{
        self.tableView.hidden = NO;
        self.PriceView.hidden = NO;
        self.EmptyView.hidden = YES;
    }
    //从新计算总价格
    self.priceLabel.text = [NSString stringWithFormat:@"共$ %.1f",cart.sumPrice];
    if ([ANMCartSingle sharedCart].count == 0) {
        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
        item.badgeValue = nil;
    }
   
    [self.tableView reloadData];
}

// 点击了去逛逛
- (IBAction)didClickGoBtn:(id)sender {
    self.tabBarController.selectedIndex = 0;
}

//创建tableview
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height -158) style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[ANMProductCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    //让价格标签显示在前面
    [self.view bringSubviewToFront:self.PriceView];
    
    
}
#pragma mark - 监听物品数量变化通知,刷新数据

//增加事件
-(void)updateSelf:(NSNotification *)no{
    [[ANMCartSingle sharedCart] addFreshModelArrObject:no.object];
    [self updateUI];
}

-(void)updateUI{
    [self.tableView reloadData];
    self.priceLabel.text = [NSString stringWithFormat:@"共$ %.1f",[ANMCartSingle sharedCart].sumPrice];
    UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
    item.badgeValue = [NSString stringWithFormat:@"%zd",[ANMCartSingle sharedCart].count];
}
//减少事件
-(void)minusSelf:(NSNotification *)no{
    
    [[ANMCartSingle sharedCart]removeFreshModelArrObject:no.object];
    [self updateUI];
    if ([ANMCartSingle sharedCart].count == 0) {
        self.priceLabel.text = [NSString stringWithFormat:@"共$ 0"];
        UITabBarItem *item = [self.tabBarController.tabBar.items objectAtIndex:2];
        item.badgeValue = nil;
        self.tableView.hidden = YES;
        self.EmptyView.hidden = NO;
        self.PriceView.hidden = YES;
    }
}

#pragma mark - 数据源,用来展示购买的商品
//有多少组
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//每组有多少个
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return [ANMCartSingle sharedCart].freshModelArr.count + 3;
    }
}

//cell的样子
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    if (indexPath.section == 0) {
        ANMPayAdressCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"CartFirstCell" owner:nil options:nil]lastObject];
        cell.adressModel = self.addressModel;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        if (indexPath.row == 0) {
            UITableViewCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"CartSecondCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            return cell;
        }else if (indexPath.row ==1) {
            UITableViewCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"CartThirdCell" owner:nil options:nil]lastObject];
//            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if(indexPath.row ==2) {
            UITableViewCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"CartForthCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            
            ANMProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
            if (cell == nil) {
                cell = [[ANMProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            ANMFreshModel *freshModel = [ANMCartSingle sharedCart].freshModelArr[indexPath.row - 3];
            cell.freshModel = freshModel;
            return cell;
        }
    }

}

//cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80;
    }else{
        return 44;
    }
}

#pragma mark - tableView选中事件

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 &&indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"DetailAddress" bundle:nil];
        DetailAddressTableViewController *v = [sb instantiateInitialViewController];
     
        
        v.addressModel = self.addressModel;
        
        
        [v setDeleteModel:^(AddressModel *model ){
            
            
            self.addressModel = model;
            
            [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
        [self.navigationController pushViewController:v animated:YES];
    }
}

@end
