//
//  DetailAddressTableViewController.m
//  ainimei
//
//  Created by user on 16/11/14.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "DetailAddressTableViewController.h"
#import <Masonry.h>
#import "AddressModel.h"
#import <SVProgressHUD.h>

@interface DetailAddressTableViewController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
/// 名字
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

/// 联系人
@property (weak, nonatomic) IBOutlet UITextField *contactTextField;

/// 城市
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

/// 区域
@property (weak, nonatomic) IBOutlet UITextField *zoneTextField;

/// 详细地址
@property (weak, nonatomic) IBOutlet UITextField *detailTextField;



/// 男生按钮
@property (weak, nonatomic) IBOutlet UIButton *manBtn;

/// 女生按钮
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;

/// 性别
@property (nonatomic, copy) NSString *gender;

/// 城市数组
@property (nonatomic, strong) NSArray *citys;

/// 城市选择pickerView
@property (nonatomic, weak) UIPickerView *cityPickerView;
@end

@implementation DetailAddressTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(didSelectAction:)];
    
    
    [self judgeShowData];
    [self replaceKeyboard];
    [self setupAccessoryView];
    
//    NSLog(@"%@",self.addressModel);
}

#pragma mark - 根据有无数据判断控制器显示内容
- (void)judgeShowData {
    if (self.addressModel == nil) {
        self.deleteCell.hidden = YES;
        self.addressModel = [[AddressModel alloc]init];
        return;
    }
    //添加显示内容
//    NSLog(@"%@",self.addressModel.accept_name);
    
    self.nameTextField.text = self.addressModel.accept_name;
    self.contactTextField.text = self.addressModel.telphone;
    self.cityTextField.text = self.addressModel.city_name;
    self.zoneTextField.text = self.addressModel.zone;
    self.detailTextField.text = self.addressModel.detailAddress;
    
   
    
    //按钮
//    NSLog(@"%@",self.addressModel.gender);
    
    if ([self.addressModel.gender isEqualToString:@"1"]) {
        self.manBtn.selected = YES;
    } else if ([self.addressModel.gender isEqualToString:@"0"]){
        self.womanBtn.selected = YES;
    }
    
    
}

#pragma mark - 保存按钮
- (void)didSelectAction:(UIBarButtonItem *)sender {
//    NSLog(@"点击了保存按钮");
    
    //赋值
    self.addressModel.accept_name = self.nameTextField.text;
    self.addressModel.telphone = self.contactTextField.text;
    self.addressModel.city_name = self.cityTextField.text;
    self.addressModel.zone = self.zoneTextField.text;
    self.addressModel.detailAddress = self.detailTextField.text;
    
    // 判断性别
    if (self.manBtn.selected == YES) {
        // 性别判断
        self.addressModel.gender = @"1";
    } else if (self.womanBtn.selected == YES) {
        self.addressModel.gender = @"0";
    }
    
    
    if (![self.addressModel.zone  isEqual: @""] && ![self.addressModel.detailAddress  isEqual: @""]) {
        //拼接字符串
        self.addressModel.address = [NSString stringWithFormat:@"%@ %@",self.addressModel.zone,self.addressModel.detailAddress];
//        NSLog(@"address---%@",self.addressModel.address );
    }
    // 判断电话号码的正则
//    BOOL result =[DetailAddressTableViewController validateMobile:self.addressModel.telphone];
    if (([self.addressModel.accept_name  isEqual: @""] || [self.addressModel.telphone  isEqual: @""] || [self.addressModel.city_name isEqual: @""]|| [self.addressModel.zone  isEqual: @""] ||[self.addressModel.detailAddress isEqual: @""] || [self.addressModel.gender isEqualToString:@""])) {
        [self showHUD:@"请填写完整信息"];
    }
//    else if (!result) {
//         [self showHUD:@"电话号码不合法"];
//    }
    
    
    else {
        
//         跳转传值
        if (self.deleteModel != nil) {
            self.addressModel.addModel = YES;
            self.deleteModel(self.addressModel);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
#pragma mark - 判断手机号码格式是否正确
// 正则判断手机号码地址格式
+ (BOOL) validateMobile:(NSString *)mobile

{
    
    //手机号以13， 15，18开头，八个 \d 数字字符
    
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:mobile];
    
}

- (void)showHUD:(NSString *)HUDString {
    [SVProgressHUD showErrorWithStatus:HUDString];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    });
}
#pragma mark - 删除按钮
- (IBAction)deleteAction:(id)sender {
//    NSLog(@"点击了删除地址");
    
    //弹出提示框
    UIAlertView *deleteAlertView = [[UIAlertView alloc]initWithTitle:@"确定删除改地址吗" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [deleteAlertView show];
    
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        //输出数据,跳转控制器
        //block回传数据
        if (self.deleteModel != nil) {
            self.addressModel.addModel = NO;
            self.deleteModel(self.addressModel);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark - 男生按钮
- (IBAction)manAction:(UIButton *)sender {
//    sender.selected = !self.womanBtn.selected;
    sender.selected = YES;
    self.womanBtn.selected = NO;
    self.gender = @"1";
    
}
#pragma mark - 女生按钮
- (IBAction)womanAction:(UIButton *)sender {
    sender.selected = YES;
    self.manBtn.selected = NO;
    self.gender = @"0";
    
}


#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - 懒加载成功获取城市
- (NSArray *)citys {
    if (_citys == nil) {
        _citys = @[@"上海市",@"北京市",@"广州市",@"天津市",@"南京市",@"成都市",@"杭州市",@"苏州市",@"深圳市",@"武汉市"];
        
    }
    return _citys;
}

#pragma mark - UIPickerViewDataSource,UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.citys.count;
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.citys objectAtIndex:row];
}

//// 获取选中的title
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
////    [pickerView
//}
#pragma mark - 创建pickerView
- (void)replaceKeyboard {
    
    
    UIPickerView *cityPickerView = [[UIPickerView alloc]initWithFrame:self.cityPickerView.inputView.bounds];
    cityPickerView.backgroundColor = [UIColor lightGrayColor];
    cityPickerView.showsSelectionIndicator=YES;
    cityPickerView.dataSource = self;
    cityPickerView.delegate = self;
    self.cityTextField.inputView = cityPickerView;
    
    self.cityPickerView = cityPickerView;
    //获取键盘弹出的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(didChangeKeyBoardFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    
}
- (void)setupAccessoryView {
    //创建附件条
    //    UIView *toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
    UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 0, 44)];
    
//    toolbar.backgroundColor = [UIColor redColor];
    self.cityTextField.inputAccessoryView = toolbar;
    // 设置取消,确定和lable
    UIBarButtonItem *sureButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureAction)];
    UIBarButtonItem *flexibaleItem1 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UILabel *cityLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    cityLable.text = @"城市选择";
    cityLable.textAlignment = NSTextAlignmentCenter;
    cityLable.textColor = [UIColor darkGrayColor];
    UIBarButtonItem *cityLableItem = [[UIBarButtonItem alloc]initWithCustomView:cityLable];
    
    UIBarButtonItem *flexibaleItem2 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancelButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancleAction)];
    
    toolbar.items = @[cancelButtonItem,flexibaleItem1,cityLableItem,flexibaleItem2,sureButtonItem ];
    
}
#pragma mark - 确定选择城市按钮
- (void)sureAction {
//    NSLog(@"点击确定");
    NSInteger row=[self.cityPickerView selectedRowInComponent:0];
    NSString *dateStr=[self.citys objectAtIndex:row];
//    NSLog(@"%@",dateStr);
    self.cityTextField.text = dateStr;
    //    点击确定按钮将pickView上面的值传给cityText,并且address字符串数据清空.
    [self.cityTextField endEditing:YES];
    //获取pickerView上显示的内容进行赋值
}

#pragma mark - 取消选择城市按钮
- (void)cancleAction {
//    NSLog(@"点击取消");
    //辞去响应者职务
    [self.cityTextField endEditing:YES];
}
#pragma mark - ChangeKeyBoardFrame
-(void)didChangeKeyBoardFrame:(NSNotification *)no {
//    NSLog(@"%@",no);
    //取出动画时长
    CGFloat timeInterval = [no.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    //获取键盘滚完后的frame
    CGRect endFrame = [no.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 获取self.cityPickerView需要设置的y值
    CGFloat offsetY = endFrame.origin.y - kScreenHeight + endFrame.size.height;

    
    [UIView animateWithDuration:timeInterval animations:^{
        self.cityPickerView.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
}
    

@end
