//
//  SugViewController.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "SugViewController.h"
#import "ZLTextView.h"

@interface SugViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *sugLabel;

@property (weak, nonatomic) IBOutlet UITextView *sugTextView;

@end

@implementation SugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"意见反馈";
    // 设置发送按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.sugLabel.text = @"感谢您对爱鲜蜂的支持与关注，我们将竭诚为您提供最详实、准确的信息，以满足网友的需求。但百密总有一疏，无论您对页面布局是否喜欢；数据信息是否有误，配图正确与否，都希望得到您客观的评价.";
    self.sugTextView.delegate = self;

    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1; //点击次数
    tapGesture.numberOfTouchesRequired = 1; //点击手指数
    [self.view addGestureRecognizer:tapGesture];
    
    self.sugTextView.text = @"请输入宝贵意见(300字以内)";
    self.sugTextView.textColor = [UIColor grayColor];
}

#pragma mark - 轻击手势触发方法
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    [self.view endEditing:YES];
}
#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    
    if ([textView.text isEqualToString:@"请输入宝贵意见(300字以内)"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"请输入宝贵意见(300字以内)";
        textView.textColor = [UIColor grayColor];
    }
}

@end
