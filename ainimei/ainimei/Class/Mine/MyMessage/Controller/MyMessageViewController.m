//
//  MyMessageViewController.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "MyMessageViewController.h"
#import "SystemMessageView.h"
#import "DSHTTPClient.h"
#import "MessageModel.h"
#import "MessageTableViewCell.h"

@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate>

/**
 信息tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;

/**
 信息模型
 */
@property (nonatomic, strong) NSArray<MessageModel *> *messages;

@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSementControl];
    [self setupMessageTableView];
    
 
}
#pragma mark - setupMessageTableView
- (void)setupMessageTableView {
    self.messageTableView.dataSource = self;
    self.messageTableView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UITableViewDataSource,UITableViewDelegate 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageTableViewCell *messageCell = [tableView dequeueReusableCellWithIdentifier:@"messageIdentifier"];
//    messageCell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    messageCell.messageModel = self.messages[indexPath.row];
    
    /// 迫不得已的实现思路
    if (indexPath.row == 2) {
        messageCell.showAllLable.hidden = YES;
    }
    return messageCell;
}


#pragma mark - 设置分页指示器
- (void)setupSementControl {
    //创建
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:@[@"系统信息",@"用户信息"]];
    //设置宽高
    [segment setWidth:80 forSegmentAtIndex:0];
    [segment setWidth:80 forSegmentAtIndex:1];
    //设置默认选中
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
    // 背景图片
    //背景图片
    [segment setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_normal"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    [segment setBackgroundImage:[UIImage imageNamed:@"v2_coupon_verify_normal"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    // 字体颜色
    [segment setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor grayColor]
                                      } forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor blackColor]
                                      } forState:UIControlStateSelected];
    
    [self myAction:segment];
    
    // 设置点击事件
    //通过UIControl的方法来设置，当改变segments的时候通过事件UIControlEventValueChanged，
    //通过action来处理事件
    [segment addTarget:self
                action:@selector(myAction:)
      forControlEvents:UIControlEventValueChanged];
    
//    思路
//    CGSize size = [label.text sizeWithFont:label.font];
//    
//    用size和label.frame.size比较
}


#pragma mark - 判断是点击哪一个
- (void)myAction:(UISegmentedControl *)sender {
    
    
        if (sender.selectedSegmentIndex == 0) {
            
            [self loadMessageDataWithString:@"SystemMessage.json.php" andValue:@"10"];
            [self.messageTableView reloadData];
            
            
            
        } else if (sender.selectedSegmentIndex == 1) {
            [self loadMessageDataWithString:@"UserMessage.json.php" andValue:@"11"];
            [self.messageTableView reloadData];
//            if (self.messages == nil) {
//                SystemMessageView *systemView = [SystemMessageView loadSystemMessageView];
//                systemView.frame = self.view.bounds;
//                self.view = systemView;
//            }
        }
}


#pragma mark - 加载数据
- (void)loadMessageDataWithString:(NSString *)URLString andValue:(NSString *)numberValue {
    // 创建可变字典参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:numberValue forKey:@"call"];
    //    call = 10
    //    http://iosapi.itcast.cn/loveBeen/UserMessage.json.php
    //    call = 11
    //    http://iosapi.itcast.cn/loveBeen/SystemMessage.json.php
    //    http://iosapi.itcast.cn/loveBeen/
    
    //请求数据
    [DSHTTPClient postUrlString:URLString withParam:param withSuccessBlock:^(id data) {
        NSArray *dataArr = data[@"data"];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in dataArr) {
           MessageModel *model = [MessageModel messageModelWithDict:dict];
            [arrM addObject:model];
        }
        self.messages = arrM.copy;
        [self.messageTableView reloadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.messages == nil) {
                SystemMessageView *systemView = [SystemMessageView loadSystemMessageView];
                systemView.frame = self.view.bounds;
                self.view = systemView;
            }
        });
        
    } withFailedBlock:^(NSError *error) {
        NSLog(@"%@",error);
    } withErrorBlock:^(NSString *message) {
        NSLog(@"%@",message);
    }];
}
@end
