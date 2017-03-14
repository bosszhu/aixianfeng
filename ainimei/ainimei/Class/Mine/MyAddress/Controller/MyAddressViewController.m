//
//  MyAddressViewController.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
/*
 收获地址需要数据
 
 */

#import "MyAddressViewController.h"
#import "AddressTableViewCell.h"
#import "DSHTTPClient.h"
#import "AddressModel.h"
#import "DetailAddressTableViewController.h"
#import "ANMCartSingle.h"


@interface MyAddressViewController () <UITableViewDataSource,UITableViewDelegate,AddressModelDelegate>
/// 收货地址TableView
@property (weak, nonatomic) IBOutlet UITableView *addressTableView;
/// 地址数组模型
@property (nonatomic, strong) NSMutableArray<AddressModel *> *addressArr;

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的收获地址";
    
    [self setupAddressTableView];
    
    //测试获取数据,成功!!
    ANMCartSingle *single = [ANMCartSingle sharedCart];
    if (single.addressArr == nil) {
        [self loadAddressData];
    } else {
        self.addressArr = single.addressArr;
        [self.addressTableView reloadData];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"v2_goback"] style:UIBarButtonItemStylePlain target:self action:@selector(popVcAction)];
    
}

#pragma mark -返回的时候保存数据
- (void)popVcAction {
    //保存用户数组
    [ANMCartSingle sharedCart].addressArr = self.addressArr;

    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"addressIdentifier"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"AddressTableViewCell" owner:self options:nil]lastObject];
    }
    // 通过tag值确定是哪个按钮被点击了
    cell.contactBtn.tag = indexPath.row;
    
    
    // 设置cell选中样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 实现自定义代理方法
    cell.delegate = self;
    
   cell.addressModel = self.addressArr[indexPath.row];
    cell.addressModel.index = indexPath.row;
    return cell;
}

#pragma mark - 实现点击代理方法
- (void)addressTableViewCellWithCell:(AddressTableViewCell *)cell {
    
//    NSLog(@"%zd---cellIndex=%zd",cell.contactBtn.tag,cell.addressModel.index);
    //跳转控制器
    //实例化sb
    UIStoryboard *detailAddressSB = [UIStoryboard storyboardWithName:@"DetailAddress" bundle:nil];
    //创建控制器
    DetailAddressTableViewController *detailAddressVc = [detailAddressSB instantiateInitialViewController];
    // 设置数据源(传值)
    detailAddressVc.addressModel = cell.addressModel;
    
            //传递数组下标为标示
    
//    self.addressArr
    
    [detailAddressVc setDeleteModel:^(AddressModel *addressModel) {
//        NSLog(@"%zd",addressModel.isAddModel);
        //作出判断(是保存还是删除)
        if (addressModel.isAddModel == YES) {
//            NSLog(@"替换");
            // 获取数组下标替换修改数组
            [self.addressArr replaceObjectAtIndex:addressModel.index withObject:addressModel];
            
        } else {
//            NSLog(@"删除");
            //删除数据
            [self.addressArr removeObject:addressModel];
        }
        //刷新表格
        [self.addressTableView reloadData];
        
    }];

    
    [self.navigationController pushViewController:detailAddressVc animated:YES];
    
}
#pragma mark - 去除点击阴影
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - 设置地址列表
- (void)setupAddressTableView {
    self.addressTableView.dataSource = self;
    self.addressTableView.delegate = self;
    self.addressTableView.rowHeight = 80;
}
#pragma mark - 添加联系人界面
- (IBAction)addAddressAction:(id)sender {
    //跳转修改地址
//    NSLog(@"跳转添加地址");
    //实例化sb
    UIStoryboard *detailAddressSB = [UIStoryboard storyboardWithName:@"DetailAddress" bundle:nil];
    //创建控制器
    DetailAddressTableViewController *detailAddressVc = [detailAddressSB instantiateInitialViewController];
    
    //block逆向传值
    [detailAddressVc setDeleteModel:^(AddressModel *addressModel) {
        //增加数据
        [self.addressArr addObject:addressModel];
        

        #pragma mark - 持久化保存
        
        
        //刷新表格
        [self.addressTableView reloadData];
    }];
    [self.navigationController pushViewController:detailAddressVc animated:YES];

    
}

#pragma mark - 获取详细地址数据
- (void)loadAddressData {
    // 创建可变字典参数
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:@"12" forKey:@"call"];
//    http://iosapi.itcast.cn/loveBeen/MyAdress.json.php
//    http://iosapi.itcast.cn/loveBeen/
    //请求数据
    [DSHTTPClient postUrlString:@"MyAdress.json.php" withParam:param withSuccessBlock:^(id data) {
        // 字典转模型
        NSArray *addressArr = data[@"data"];
        NSMutableArray *addressArrM = [NSMutableArray array];
        //遍历数组字典转模型
        for (NSDictionary *dict in addressArr) {
            AddressModel *address = [AddressModel addressModelWithDict:dict];
            
            [addressArrM addObject:address];
        }
        self.addressArr = addressArrM;
        
      #pragma mark - 持久化保存
        
        //刷新数据源
        [self.addressTableView reloadData];
        

    } withFailedBlock:^(NSError *error) {
        NSLog(@"请求失败%@",error);
    } withErrorBlock:^(NSString *message) {
        
    }];
}

@end
