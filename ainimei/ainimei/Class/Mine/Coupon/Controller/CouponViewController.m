//
//  CouponViewController.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "CouponViewController.h"
#import <YYModel.h>
#import "DSHTTPClient.h"
#import "CouponModel.h"
#import "CouponHeaderView.h"
#import "CouponTableViewCell.h"
#import "InvailCouponTableViewCell.h"
#import <SVProgressHUD.h>

#define couponNotificationName @"couponNotificationName"

@interface CouponViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 模型数组
 */
@property (nonatomic, strong) NSArray *couponArr;

/**
 优惠券tableview
 */
@property (weak, nonatomic) IBOutlet UITableView *couponTableView;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"使用规则" style:UIBarButtonItemStylePlain target:self action:@selector(useRuleAction)];
    self.navigationItem.title = @"优惠券";
    [self loadCouponData];
    [self couponHeaderView];
    [self setupcouponTableView];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(haha:) name:couponNotificationName object:nil];

}

//- (void)haha:(NSNotification *)no {
//    NSLog(@"%@",((CouponModel *)no.object).name);
//}

#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.couponArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CouponModel *coupon = self.couponArr[indexPath.row];
    //没过期
    if (coupon.expired == NO) {
        //加载黄色xib
        CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"couponIdentifier"];
        if (cell == nil) {
            //从xib加载
            cell = [[[NSBundle mainBundle] loadNibNamed:@"CouponTableViewCell" owner:self options:nil]lastObject];
        }
        cell.couponModel = coupon;
        //根据是否有效加载不同的xib
        return cell;
    }
    else {
        //加载灰色xib
        InvailCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InvailIdentifier"];
        if (cell == nil) {
            //从xib加载
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InvailCouponTableViewCell" owner:self options:nil]lastObject];
        }
        cell.couponModel = coupon;
        return cell;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%zd",indexPath.row);
    //获取到cell指定的数据源
    CouponTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.couponModel.isExpired) {
        [self showHUD:@"过期不可使用"];
        
    } else {
        [[NSNotificationCenter defaultCenter] postNotificationName:couponNotificationName object:cell.couponModel userInfo:nil];
        [self.navigationController popViewControllerAnimated:YES];
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
#pragma mark - setupcouponTableView
- (void)setupcouponTableView {
    self.couponTableView.delegate = self;
    self.couponTableView.dataSource = self;
    // 显示正确,不要弹簧
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.couponTableView.estimatedRowHeight = 139;
    self.couponTableView.rowHeight = UITableViewAutomaticDimension;
    
}
- (void)couponHeaderView {
    UIView *headerView = [CouponHeaderView loadCouponHeaderView];
    headerView.frame = CGRectMake(0, 64, kScreenWidth, 50);
//    headerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:headerView];
}
// 加载数据
- (void)loadCouponData {
    // 创建可变字典参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"9" forKey:@"call"];
//    http://iosapi.itcast.cn/loveBeen/MyCoupon.json.php
    [DSHTTPClient postUrlString:@"MyCoupon.json.php" withParam:param withSuccessBlock:^(NSDictionary *data) {
//        NSLog(@"%@",data);
        NSArray *array = data[@"data"];
        
        NSArray *dataArray = [NSArray yy_modelArrayWithClass:[CouponModel class] json:array];
        self.couponArr = dataArray;
        [self.couponTableView reloadData];
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}


#pragma mark - 使用规则
- (void)useRuleAction {
//    NSLog(@"使用规则");
    
    //跳转
    UIStoryboard *MMSB = [UIStoryboard storyboardWithName:@"MM" bundle:nil];
    //创建控制器
    UIViewController *MMVc = [MMSB instantiateInitialViewController];
    [self.navigationController pushViewController:MMVc animated:YES];
}
@end
