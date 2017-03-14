//
//  MineViewController.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadView.h"
#import "PrefixHeader.pch"
#import "MineTableViewCell.h"
#import "MyOrderViewController.h"
#import "CouponViewController.h"
#import "MyMessageViewController.h"
#import "VipTableViewController.h"
#import "PrefixHeader.pch"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface MineViewController () <UITableViewDataSource,UITableViewDelegate,MineHeadViewDelegate,UIAlertViewDelegate>
/// 头部视图
@property (weak, nonatomic) IBOutlet UIView *headView;
/// 下面表格
@property (weak, nonatomic) IBOutlet UITableView *MineTableView;

@end

@implementation MineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupHeadView];
    [self setupTableView];
    
    
    [self setupAppearanceTintColor];
}

#pragma mark - 修改全局文字渲染色
- (void)setupAppearanceTintColor {
    
    [[UINavigationBar appearance] setTintColor:myNavBarColor];
    [UITableViewCell appearance].selectionStyle = UITableViewCellSelectionStyleNone;
//    NSDictionary *Attridict = [NSDictionary dic]
    
    NSDictionary *attribute = @{
                                NSForegroundColorAttributeName:myNavBarColor
                                };
    [[UITabBarItem appearance] setTitleTextAttributes:attribute forState:UIControlStateSelected];
    

}

#pragma mark - UITableViewDataSource,UITableViewDelegate 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    } else if (section == 1) {
        return 1;
    } else {
        return 2;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UIImage *imgae1 = [UIImage imageNamed:@"v2_my_address_icon"];
    UIImage *imgae2 = [UIImage imageNamed:@"icon_mystore"];
    UIImage *imgae3 = [UIImage imageNamed:@"v2_my_share_icon"];
    UIImage *imgae4 = [UIImage imageNamed:@"v2_my_serviceonline_icon"];
    UIImage *imgae5 = [UIImage imageNamed:@"v2_my_feedback_icon"];
    
    MineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MineTableViewCell" owner:self options:nil]lastObject];
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.cellImageView.image = imgae1;
        cell.cellTextLable.text = @"我的收货地址";
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        cell.cellImageView.image = imgae2;
        cell.cellTextLable.text = @"我的店铺";
    }  else if (indexPath.section == 1) {
        cell.cellImageView.image = imgae3;
        cell.cellTextLable.text = @"把爱疯先分享给好友";
    } else if (indexPath.section == 2 && indexPath.row == 0) {
        cell.cellImageView.image = imgae4;
        cell.cellTextLable.text = @"客服帮助";
    }  else if (indexPath.section == 2 && indexPath.row == 1) {
        cell.cellImageView.image = imgae5;
        cell.cellTextLable.text = @"意见反馈";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - 点击cell跳转不同的控制器
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
//        NSLog(@"我的收获地址页面");
        UIStoryboard *myAddressSB = [UIStoryboard storyboardWithName:@"MyAddress" bundle:nil];
        //创建控制器
        UIViewController *myAddressVc = [myAddressSB instantiateInitialViewController];
        [self.navigationController pushViewController:myAddressVc animated:YES];
        
    } else if (indexPath.section == 0 && indexPath.row == 1) {
        // 跳转我的店铺控制器
        //实例化sb
        UIStoryboard *myStoreSB = [UIStoryboard storyboardWithName:@"MyStore" bundle:nil];
        //创建控制器
        UIViewController *myStoreVc = [myStoreSB instantiateInitialViewController];
        [self.navigationController pushViewController:myStoreVc animated:YES];
        
    }  else if (indexPath.section == 1) {
//        NSLog(@"分享");
        //实现实录shareSDK,弹出分享
        
        [self showShareSDK];
        
    } else if (indexPath.section == 2 && indexPath.row == 0) {
//        NSLog(@"客服帮助");
        //弹出提示框
        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18270822163"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        UIAlertView *deleteAlertView = [[UIAlertView alloc]initWithTitle:@"182-7082-2163" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
//        [deleteAlertView show];
        
    }  else if (indexPath.section == 2 && indexPath.row == 1) {
        //跳转意见反馈控制器
        //实例化sb
        UIStoryboard *sugSB = [UIStoryboard storyboardWithName:@"Suggestion" bundle:nil];
        //创建控制器
        UIViewController *sugVc = [sugSB instantiateInitialViewController];
        [self.navigationController pushViewController:sugVc animated:YES];
    }
}
#pragma mark - 分享功能
- (void)showShareSDK {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享到" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(alert) wAlert = alert;
    [wAlert addAction:[UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        
        
    }]];
    [wAlert addAction:[UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        
        
    }]];
    [wAlert addAction:[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        [self shareWiebo];
        
    }]];
    [wAlert addAction:[UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        NSLog(@"%@",[wAlert.textFields.firstObject text]);
        
    }]];
    
    [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:wAlert animated:YES completion:nil];
    
    
}
#pragma mark - 分享微博
- (void)shareWiebo {
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"MM"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"ANM小组牛不牛"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.jianshu.com/users/5ad33f76b079/latest_articles"]
                                          title:@"ANNM牛牛牛"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}
//#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (buttonIndex == 1) {
//        // 拨打电话.
//        NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18270822163"];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//    }
//}

#pragma mark - setupTableView
- (void)setupTableView {
    self.MineTableView.dataSource = self;
    self.MineTableView.delegate = self;
    self.MineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark - 设置headView
- (void)setupHeadView {
    MineHeadView *headView = [MineHeadView loadHeadView];
    headView.frame = CGRectMake(0, -20, kScreenWidth, 300);
    [self.headView addSubview:headView];
    headView.delegate = self;
}

#pragma mark - MineHeadViewDelegate
- (void)mineHeadViewDidButton:(UIButton *)sender {
    //根据tag值跳转不同的控制器
    switch (sender.tag) {
        case 50:
        {
//            NSLog(@"设置界面");
            UIStoryboard *settingSB = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
            //创建控制器
            MyOrderViewController *settingVc = [settingSB instantiateInitialViewController];
            [self.navigationController pushViewController:settingVc animated:YES];
        }
            break;
        case 60:
        {
//            NSLog(@"我的订单界面界面");
            UIStoryboard *myOrderSB = [UIStoryboard storyboardWithName:@"MyOrder" bundle:nil];
            //创建控制器
            MyOrderViewController *myOrderVc = [myOrderSB instantiateInitialViewController];
            [self.navigationController pushViewController:myOrderVc animated:YES];
        }
            break;
        case 70:
        {
//            NSLog(@"优惠券界面");
            UIStoryboard *couponSB = [UIStoryboard storyboardWithName:@"Coupon" bundle:nil];
            //创建控制器
            CouponViewController *couponVc = [couponSB instantiateInitialViewController];
            [self.navigationController pushViewController:couponVc animated:YES];
        }
            break;
        case 80:
        {
//            NSLog(@"我的消息界面界面");
            UIStoryboard *myMessageSB = [UIStoryboard storyboardWithName:@"MyMessage" bundle:nil];
            //创建控制器
            MyMessageViewController *myMessageVc = [myMessageSB instantiateInitialViewController];
            [self.navigationController pushViewController:myMessageVc animated:YES];
        }
            break;
        case 90:
        {
//            NSLog(@"Vip界面");
            UIStoryboard *vipSB = [UIStoryboard storyboardWithName:@"Vip" bundle:nil];
            //创建控制器
            VipTableViewController *vipVc = [vipSB instantiateInitialViewController];
            [self.navigationController pushViewController:vipVc animated:YES];
        }
        default:
            break;
    }
    
}
#pragma mark - 隐藏导航栏
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


@end
