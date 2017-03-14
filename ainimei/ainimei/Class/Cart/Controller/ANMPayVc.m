//
//  ANMPayVc.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMPayVc.h"
#import "ANMPayProductCell.h"
#import "ANMFreshModel.h"
#import "ANMCartSingle.h"
#import "CouponViewController.h"
#import "CouponModel.h"
#import "PayFirstCell.h"
#import "PayForthCell.h"
#import <SVProgressHUD.h>

@interface ANMPayVc ()<UITableViewDataSource,UITableViewDelegate>

//结算页tableview
@property (nonatomic, weak) UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *PriceView;
//底部总价格标签

@property (weak, nonatomic) IBOutlet UILabel *allSumPriceLabel;
@property (nonatomic, strong) CouponModel *couponModel;

@end

@implementation ANMPayVc

static NSString * cellID = @"payCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    
    //跟新底部的价格
    self.allSumPriceLabel.text = [NSString stringWithFormat:@"实付金额: $%.1f",[ANMCartSingle sharedCart].sumPrice + 8] ;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(freeTicket:) name:@"couponNotificationName" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

// 懒加载
-(CouponModel *)couponModel{
    if (_couponModel == nil) {
        _couponModel = [CouponModel new];
        _couponModel.name = @"一张优惠券";
        _couponModel.value = @"0";
    }
    return _couponModel;
}

#pragma mark - tableView初始化及设置
-(void)setupTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView = tableView;
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[ANMPayProductCell class] forCellReuseIdentifier:cellID];
    [self.view addSubview:tableView];
    //让价格标签显示在前面
    [self.view bringSubviewToFront:self.PriceView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return [ANMCartSingle sharedCart].freshModelArr.count +1;
    }else{
        return 1;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayFirstCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"PayFirstCell" owner:nil options:nil]lastObject];
        cell.couponModel = self.couponModel;
        return cell;
    }else if(indexPath.section == 1){
        UITableViewCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"PaySecondCell" owner:nil options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }else if(indexPath.section == 2){
        if (indexPath.row == [ANMCartSingle sharedCart].freshModelArr.count) {
            UITableViewCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"PaySumCell" owner:nil options:nil]lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
        ANMPayProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[ANMPayProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        cell.freshModel = [ANMCartSingle sharedCart].freshModelArr[indexPath.row];
        return cell;
        }
    }else{
        PayForthCell *cell =  [[[NSBundle mainBundle]loadNibNamed:@"PayForthCell" owner:nil options:nil]lastObject];
        cell.couponModel = self.couponModel;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        return 160;
    }else if(indexPath.section == 3){
        return 100;
    }else{
        return 35;
    }
}
#pragma mark - 每组组头ui设计
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 35)];
    sectionHeader.backgroundColor = [UIColor whiteColor];
    UILabel *sectionLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 120, 20)];
    sectionLabel.textColor = [UIColor lightGrayColor];
    sectionLabel.font = [UIFont systemFontOfSize:14];
    [sectionHeader addSubview:sectionLabel];
    switch (section) {
        case 0:
            sectionLabel.text = @"";
            break;
        case 1:
            sectionLabel.text = @"选择支付方式";
            break;
        case 2:
            sectionLabel.text = @"精选商品";
            break;
        case 3:
            sectionLabel.text = @"费用明细";
            break;
            
        default:
            break;
    }
    return sectionHeader;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 35;
    }
}

#pragma mark - 响应事件及通知事件
- (IBAction)didClickBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)didClickPayBtn:(id)sender {
}

#pragma mark - tableview点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Coupon" bundle:nil];
        CouponViewController *v = [sb instantiateInitialViewController];
        [self.navigationController pushViewController:v animated:YES];
    }
}

-(void)freeTicket:(NSNotification *)no{
    //刷新cell的label 实付金额
    self.couponModel = no.object;
    NSIndexPath *indexP = [NSIndexPath indexPathForRow:0 inSection:0];
    NSIndexPath *indexL = [NSIndexPath indexPathForRow:0 inSection:3];
    [self.tableView reloadRowsAtIndexPaths:@[indexP,indexL] withRowAnimation:UITableViewRowAnimationNone];
//    NSLog(@"%zd",self.couponModel.value.integerValue);
    self.allSumPriceLabel.text = [NSString stringWithFormat:@"实付金额: $%.1f",[ANMCartSingle sharedCart].sumPrice + 8 - self.couponModel.value.integerValue];
}
- (IBAction)doneBtn:(id)sender {
    //清空购物车
    [[ANMCartSingle sharedCart] removeAllFreshModel];
    //自动改变底部的计数条
    [self showHUD:@"正在生成订单"];
    //pop出页面
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showHUD:(NSString *)HUDString {
    [SVProgressHUD showInfoWithStatus:HUDString];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}

@end
