//
//  HMLoopView.h
//  01-网易新闻-(掌握)
//
//  Created by HM on 16/9/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLoopView : UIView

/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray <NSString *> *URLs;
/**
 *  标题数组
 */
@property (nonatomic, strong) NSArray *titles;
/**
 *  选中图片回调
 */
@property (nonatomic, copy) void (^didSelected)(NSInteger index);

/**
 *  时间间隔:多少秒自动切换图片
 */
@property (nonatomic, assign) NSInteger timerInterval;
/**
 *  设置是否启动定时器进行自动播放 YES:启动  NO:不启动  默认值是YES
 */
@property (nonatomic, assign) BOOL enableTimer;

/**
 *  快速初始化无限轮播器
 *
 *  @param URLs   图片数组
 *  @param titles 标题数组
 *  @param didSelected 选中图片回调
 */
- (instancetype)initWithURLs:(NSArray <NSString *> *)URLs titles:(NSArray <NSString *>*)titles didSelected:(void (^)(NSInteger index))didSelected;
@end
