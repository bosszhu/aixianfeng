//
//  ANMWebVc.m
//  ainimei
//
//  Created by kingLee on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMWebVc.h"

@interface ANMWebVc ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ANMWebVc

- (void)viewDidLoad {
    [super viewDidLoad];
   
}



-(void)setUrlStr:(NSString *)urlStr{
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = self.view.bounds;
    [self.view addSubview:webView];
    self.webView = webView;
    webView.scalesPageToFit = YES;
    
    
    webView.delegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [webView loadRequest:request];
}


@end
