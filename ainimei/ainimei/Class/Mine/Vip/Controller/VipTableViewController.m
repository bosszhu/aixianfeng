//
//  VipTableViewController.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "VipTableViewController.h"
#import "VipHeaderView.h"
#import "VipModel.h"
#import "VipTableViewCell.h"

@interface VipTableViewController ()
@property (nonatomic, strong) NSArray<VipModel *> *vipArr;

@end

@implementation VipTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员中心";

    VipHeaderView *headerView = [VipHeaderView loadVipHeaderView];
    headerView.frame = CGRectMake(0, 0, kScreenWidth, 300);
    self.tableView.tableHeaderView = headerView;
    
    // 设置预估行高
    //预估行高
    self.tableView.estimatedRowHeight = 100;
//    //指定计算行高
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.vipArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VipTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"vipCell"];
    cell.model = self.vipArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    
    
    //这个方法会回调代理方法,roload会回调数据源方法,都要写
    [tableView beginUpdates];
    [tableView endUpdates];
    
    //发出通知刷新单行数据
}

#pragma mark - 返回行高的方法(这个行高需要根据真实数据判断高度)
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    根据indexPath
    //获取字典中选择的值
    
    return 85;
}
#pragma mark - 懒加载自创数据
- (NSArray<VipModel *> *)vipArr {
    if (_vipArr == nil) {
        _vipArr = [[NSArray alloc] init];
        NSDictionary *dict1 = @{@"icnImage":@"guide_40_1",
                                @"title":@"成长值",
                                @"text":@"没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据"
                                };
        
        NSDictionary *dict2 = @{@"icnImage":@"guide_40_2",
                                @"title":@"成长值",
                                @"text":@"没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,没数据啊没数据,"
                                };
        NSDictionary *dict3 = @{@"icnImage":@"guide_40_1",
                                @"title":@"成长值",
                                @"text":@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"
                                };
        NSDictionary *dict4 = @{@"icnImage":@"guide_40_4",
                                @"title":@"成长值",
                                @"text":@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈"
                                };
        
        VipModel *model1 = [VipModel vipModelWithDict:dict1];
        VipModel *model2 = [VipModel vipModelWithDict:dict2];
        VipModel *model3 = [VipModel vipModelWithDict:dict3];
        VipModel *model4 = [VipModel vipModelWithDict:dict4];
        _vipArr = @[model1,model2,model3,model4];
    }
    return _vipArr;
}
@end
