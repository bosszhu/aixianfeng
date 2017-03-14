//
//  DetailAddressViewController.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "DetailAddressViewController.h"

@interface DetailAddressViewController ()
@property (weak, nonatomic) IBOutlet UITableView *changeTableView;

@end

@implementation DetailAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改地址";
    [self setupTableView];
}
#pragma mark - 设置表格.
- (void)setupTableView {
//    NSLog(@"设置主界面UI");
    
}

@end
