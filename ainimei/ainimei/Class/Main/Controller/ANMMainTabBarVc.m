//
//  ANMMainTabBarVc.m
//  ainimei
//
//  Created by kingLee on 16/11/12.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMMainTabBarVc.h"
#import "AdvertiseViewController.h"

@interface ANMMainTabBarVc ()

@end

@implementation ANMMainTabBarVc

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    [self addChildViewControllers];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
}

- (void)pushToAd {
    
    AdvertiseViewController *adVc = [[AdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
    
}

- (void)addChildViewControllers
{
    
    //主页
    UINavigationController *homeNav = [self boardWithName:@"Home"];
    homeNav.tabBarItem.title = @"主页";
    homeNav.title = @"主页";
    [homeNav.tabBarItem setImage:[UIImage imageNamed:@"v2_home"]];
    [homeNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"v2_home_r"]];
    //闪购超市
    UINavigationController *marketNav = [self boardWithName:@"Market"];
    marketNav.tabBarItem.title = @"闪购超市";
    [marketNav.tabBarItem setImage:[UIImage imageNamed:@"v2_order"]];
    [marketNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"v2_order_r"]];
    marketNav.title = @"闪购超市";
    //购物车 此处用一个占位符,用来modal一个购物车界面//购物车 shopCart_r
    UINavigationController *cartNav = [self boardWithName:@"Cart"];
    cartNav.tabBarItem.title = @"购物车";
    [cartNav.tabBarItem setImage:[UIImage imageNamed:@"shopCart"]];
    [cartNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"shopCart_r"]];
    cartNav.title = @"购物车";
    //我的
    UINavigationController *mineNav = [self boardWithName:@"Mine"];
    mineNav.tabBarItem.title = @"我的";
    [mineNav.tabBarItem setImage:[UIImage imageNamed:@"v2_my"]];
    [mineNav.tabBarItem setSelectedImage:[UIImage imageNamed:@"v2_my_r"]];
    mineNav.title = @"我的";

    self.viewControllers = @[homeNav,marketNav,cartNav,mineNav];
    
}
//根据storyboard初始化子控制器
- (UINavigationController *)boardWithName:(NSString *)boardName
{
    //1.获取board文件
    UIStoryboard *board = [UIStoryboard storyboardWithName:boardName bundle:nil];
    
    //2.初始化控制器
    UINavigationController *navVc = [board instantiateInitialViewController];
    
    
    return navVc;
    
}

//添加购物车按钮
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


@end
