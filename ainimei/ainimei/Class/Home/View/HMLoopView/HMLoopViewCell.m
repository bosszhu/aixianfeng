//
//  HMLoopViewCell.m
//  01-网易新闻-(掌握)
//
//  Created by HM on 16/9/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMLoopViewCell.h"
#import <UIImageView+WebCache.h>
@interface HMLoopViewCell()
@property (nonatomic, weak) UIImageView *iconView;
//@property (nonatomic, weak) UIButton *iconBtn;
@end

@implementation HMLoopViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 创建图片
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        // 记录属性
        self.iconView = iconView;
        
        // 创建可点击的btn
//        UIButton *iconBtn = [UIButton new];
//        self.iconBtn = iconBtn;
//        [self.contentView addSubview:iconBtn];
//        [self bringSubviewToFront:iconBtn];
//        [iconBtn addTarget:self action:@selector(jumpToUrl) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setUrl:(NSURL *)url {
    _url  = url;
    [self.iconView sd_setImageWithURL:url placeholderImage:nil options:SDWebImageRetryFailed | SDWebImageLowPriority];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
//    self.iconBtn.frame = self.bounds;
}

-(void)jumpToUrl{
//    NSLog(@"hahh");
}


@end
