//
//  HMLoopView.m
//  01-网易新闻-(掌握)
//
//  Created by HM on 16/9/13.
//  Copyright © 2016年 HM. All rights reserved.
//

#import "HMLoopView.h"
#import "HMLoopViewLayout.h"
#import "HMLoopViewCell.h"
#import "HMWeakTimerTargetObject.h"

@interface HMLoopView() <UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  collectionView
 */
@property (nonatomic, weak) UICollectionView *collectionView;

/**
 *  新闻标题
 */
@property (nonatomic, weak) UILabel *titleLabel;
/**
 *  分页指示器
 */
@property (nonatomic, weak) UIPageControl *pageControl;

/**
 *  定时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HMLoopView
static NSString *cellId = @"headline";
/**
 *  快速初始化无限轮播器
 *
 *  @param URLs   图片数组
 *  @param titles 标题数组
 */
- (instancetype)initWithURLs:(NSArray <NSString *> *)URLs titles:(NSArray <NSString *>*)titles didSelected:(void (^)(NSInteger))didSelected{
    if (self = [super init]) {
        // 记录属性
        self.URLs = URLs;
        self.titles = titles;
        self.didSelected = didSelected;
    }
    return self;
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    if (!titles.count)return;
    self.titleLabel.text = titles[0];
}

- (void)setURLs:(NSArray<NSString *> *)URLs {
    _URLs = URLs;
    // 设置页数
    self.pageControl.numberOfPages = self.URLs.count;
    // 通知重新布局
    [self setNeedsLayout];
    
    if (self.URLs.count > 1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // 创建indexPath
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.URLs.count inSection:0];
            // 滚动到指定的索引下
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            // 添加定时器
            [self addTimer];
        });
    } else {
        // 禁止定时器
        self.enableTimer = NO;
    }
    // 刷新collectionView
    [self.collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupUI];
    }
    return self;
}

#pragma mark - 设置界面
- (void)setupUI {
    // 创建collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[HMLoopViewLayout alloc] init]];
    // 设置背景颜色
    collectionView.backgroundColor = [UIColor whiteColor];
    // 注册cell
    [collectionView registerClass:[HMLoopViewCell class] forCellWithReuseIdentifier:cellId];
    // 设置数据源
    collectionView.dataSource = self;
    // 设置代理
    collectionView.delegate = self;
    // 添加到当前view上
    [self addSubview:collectionView];
    
    // 创建标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.backgroundColor = [UIColor blueColor];
    [self addSubview:titleLabel];
    
    // 创建分页指示器
    UIPageControl *pageControl = [[UIPageControl alloc] init];
//    pageControl.backgroundColor = [UIColor orangeColor];
    // 当只有一页时隐藏分页指示器
    pageControl.hidesForSinglePage = YES;
    // 设置当前选中点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    // 设置其他点的颜色
    pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
    
    // 记录属性
    self.collectionView = collectionView;
    self.titleLabel = titleLabel;
    
    // 默认两秒自动切换图片
    self.timerInterval = 2;
    self.enableTimer = YES;
}

/**
 *  布局子控件frame
 */
- (void)layoutSubviews {
    // 一定要调用父类
    [super layoutSubviews];
    
    // 设置collectionView尺寸
    self.collectionView.frame = self.bounds;
    
    // 设置分页指示器的frame
    CGSize pageSize = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    CGFloat marginX = 15;
    CGFloat pageControlH = pageSize.height;
    CGFloat pageControlW = pageSize.width;
    CGFloat pageControlY = self.frame.size.height - pageControlH;
    CGFloat pageControlX = self.frame.size.width - pageControlW - marginX;
    self.pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
//    NSLog(@"self.pageControl.frame = %zd",self.pageControl.numberOfPages);
    // 设置标题的frame
    CGFloat titleX = marginX;
    CGFloat titleH = pageControlH;
    CGFloat titleW = pageControlX - 2 * marginX;
    CGFloat titleY = pageControlY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

#pragma mark - 定时器相关方法
- (void)addTimer {
    if (!self.enableTimer) return;
    if (self.timer) return;
    // 创建定时器
    NSTimer *timer = [HMWeakTimerTargetObject scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // 记录属性
    self.timer = timer;
}

- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}

/**
 *  定时器回调方法
 */
- (void)nextImage {
    // 获得宽度
    CGFloat width = self.collectionView.bounds.size.width;
    // 获得x方向的偏移量
    CGFloat offsetX = self.collectionView.contentOffset.x;
    // 计算当前显示页号
    NSInteger page =  offsetX / width; // 3
    // 页号加一
    page++; // 4
    // 修改偏移量
    [self.collectionView setContentOffset:CGPointMake(page * width, 0) animated:YES];
}

#pragma mark - UICollectionViewDelegate 代理方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelected) {
        self.didSelected(indexPath.item % self.URLs.count);
    }
}

/**
 *  只有发生滚动就会触发该方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获得宽度
    CGFloat width = scrollView.bounds.size.width;
    // 获得x方向的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算当前显示页号
    NSInteger page =  (offsetX / width + 0.5);
//    NSLog(@"page = %zd",page);
    
    // 设置标题
    self.pageControl.currentPage = page % self.URLs.count;
    if (self.titles.count > 0) {
        self.titleLabel.text = self.titles[self.pageControl.currentPage];
    }
    [self scrollViewDidEndDecelerating:scrollView];
}

/**
 *  当开始拖拽时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeTimer];
}

/**
 *  当滚动动画停止时调用(使用定时器自动播放才会触发)
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    NSLog(@"%s", __FUNCTION__);
    [self scrollViewDidEndDecelerating:scrollView];
}

/**
 *  使用定时器自动滚动不会触发该方法,只有使用手动滚动时才会触发
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    NSLog(@"%s", __FUNCTION__);
    // 获得宽度
    CGFloat width = scrollView.bounds.size.width;
    // 获得x方向的偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    // 计算当前显示页号
    NSInteger page =  offsetX / width;
//    NSLog(@"page = %zd",page);
    // 判断是否是第一张
    if(page == 0) {
        scrollView.contentOffset = CGPointMake(self.URLs.count * width, 0);
    } else if (page == [self.collectionView numberOfItemsInSection:0] - 1) { // 最后一张
        scrollView.contentOffset = CGPointMake((self.URLs.count - 1) * width, 0);
    }
    
    // 添加定时器
    [self addTimer];
}


#pragma mark - UICollectionViewDataSource 数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    NSLog(@"%zd---%s", self.URLs.count,__FUNCTION__);
    return (self.URLs.count > 1) ? self.URLs.count * 2:self.URLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 取cell
    HMLoopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    // 传递数据
    cell.url = [NSURL URLWithString:self.URLs[indexPath.item % self.URLs.count]];
    // 返回cell
    return cell;
}


@end
