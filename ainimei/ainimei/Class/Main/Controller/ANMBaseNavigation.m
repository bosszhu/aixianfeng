//
//  ANMBaseNavigation.m
//  ainimei
//
//  Created by kingLee on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMBaseNavigation.h"

@interface ANMBaseNavigation ()

@end

@implementation ANMBaseNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:1.00 green:0.84 blue:0.19 alpha:1.00]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}



- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏tabBar
    viewController.hidesBottomBarWhenPushed = YES;
    [super pushViewController:viewController animated:animated];

}



@end
