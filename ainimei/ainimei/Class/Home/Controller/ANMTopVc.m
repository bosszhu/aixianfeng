//
//  ANMTopVc.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMTopVc.h"
#import "HMLoopView.h"
#import <SDWebImage/UIButton+WebCache.h>
#import "ANMHomeBtn.h"
#import "ANMWebVc.h"


@interface ANMTopVc ()
@property (nonatomic, strong) HMLoopView *loopView;
@property (nonatomic, strong) UIView *btnView;
@end

//此类用来管理首页头部的轮播期和图片按钮
@implementation ANMTopVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


// 赋值与加载方法
-(void)setTopModelArr:(NSArray<ANMTopModel *> *)topModelArr{
    _topModelArr = topModelArr;
    [self.view addSubview:self.loopView];
}

-(void)setBtnModelArr:(NSArray<ANMBtnModel *> *)btnModelArr{
    _btnModelArr = btnModelArr;
    [self.view addSubview:self.btnView];
}

#pragma mark - 懒加载轮播器
- (HMLoopView *)loopView {
    if (_loopView == nil) {
        // 获得图片数组
        NSArray *imgs = [self.topModelArr valueForKeyPath:@"img"];
        // 获得标题数组
        NSArray *titles = [self.topModelArr valueForKeyPath:@"name"];
        
        _loopView = [[HMLoopView alloc] initWithURLs:imgs titles:titles didSelected:^(NSInteger index) {
            //跳转url
            ANMWebVc *webView = [ANMWebVc new];
            webView.view.backgroundColor = [UIColor whiteColor];
            webView.urlStr = self.topModelArr[index].toURL;
            [self.navigationController pushViewController:webView animated:YES];
        }];
        // 设置frame
        _loopView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,150);
    }
    return _loopView;
}
#pragma mark - 一排btn的view
-(UIView *)btnView{
    if (_btnView == nil) {
        _btnView = [[UIView alloc]initWithFrame:CGRectMake(0, 145, [UIScreen mainScreen].bounds.size.width, 60)];
       
        
        //循环遍历添加按钮
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - 280)/5;
        for (int i = 0; i < 4; ++i) {
            ANMHomeBtn *btn = [[ANMHomeBtn alloc]initWithFrame:CGRectMake(i*(70 + margin)+margin, 0, 70, 70)];
            [_btnView addSubview:btn];
            btn.tag = 100+i;
            [btn sd_setImageWithURL:[NSURL URLWithString:self.btnModelArr[i].img] forState:UIControlStateNormal];
            [btn setTitle:self.btnModelArr[i].name forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [btn addTarget:self action:@selector(btnJump:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    return _btnView;
}

#pragma mark - 点击按钮事件
-(void)btnJump:(UIButton *)sender{
   
    ANMWebVc *webView = [ANMWebVc new];
    webView.view.backgroundColor = [UIColor whiteColor];
    webView.urlStr = self.btnModelArr[sender.tag - 100].customURL;
    [self.navigationController pushViewController:webView animated:YES];
    
}

@end
