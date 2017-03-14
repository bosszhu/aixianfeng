//
//  HMLoopViewLayout.m
//  01-网易新闻-(掌握)
//
//  Created by HM on 16/9/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMLoopViewLayout.h"

@implementation HMLoopViewLayout
/**
 *  准备布局时调用
 */
- (void)prepareLayout {
    [super prepareLayout];
  
    if(CGSizeEqualToSize(CGSizeZero, self.collectionView.bounds.size)) return;
    self.itemSize = self.collectionView.bounds.size;
    // 设置滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // 设置item之间的间距
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    // 设置分页效果
    self.collectionView.pagingEnabled = YES;
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    // 取消弹簧效果
    self.collectionView.bounces = NO;
}
@end
