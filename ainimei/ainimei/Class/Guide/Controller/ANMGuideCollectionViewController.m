//
//  ANMGuideCollectionViewController.m
//  ainimei
//
//  Created by user on 16/11/17.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMGuideCollectionViewController.h"
#import "ANMGuideCollectionViewCell.h"
#import "ANMMainTabBarVc.h"
#import <Masonry.h>


@interface ANMGuideCollectionViewController ()

@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation ANMGuideCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
   
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.collectionView registerClass:[ANMGuideCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    //添加pageControl
    [self addPageControl];
    //添加体验按钮
    [self addStartBtn];
}


- (void)addPageControl {
    
    
//    UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = 4;
    pageControl.currentPage = 0;
    
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
     pageControl.pageIndicatorTintColor = [UIColor yellowColor];
    [self.collectionView addSubview:pageControl];
    [self.view bringSubviewToFront:pageControl];
    self.pageControl = pageControl;
     //布局pageControl
   [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.equalTo(self.view);
       make.bottom.equalTo(self.view.mas_bottom).offset(-15);
   }];
    
}
//3.添加立即体验的按钮
- (void)addStartBtn
{
    
    // 设置开始体验按钮
    UIImage *startImage = [UIImage imageNamed:@"icon_next"];
    UIButton *btn = [[UIButton alloc]init];
    [btn setImage:startImage forState:UIControlStateNormal];
    
    CGFloat btnX = 3 * kScreenWidth + (kScreenWidth - startImage.size.width) * 0.5;
    
    btn.frame = CGRectMake(btnX, kScreenHeight * 0.85, startImage.size.width, startImage.size.height);
    
    //监听
    [btn addTarget:self action:@selector(clickStartBtn:) forControlEvents:UIControlEventTouchUpInside];
    //添加
    [self.collectionView addSubview:btn];
    
}

#pragma mark - 配置pageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//    1.计算页数
    CGPoint offset =  scrollView.contentOffset;
    CGFloat offsetX = offset.x;
    NSInteger current = (int)((offsetX/kScreenWidth) + 0.5);
    self.pageControl.currentPage = current;
}
#pragma mark - 跳转主控制器
- (void)clickStartBtn:(UIButton *)sender
{
    //1.创建tabBarVc
    ANMMainTabBarVc *v = [ANMMainTabBarVc new];
    
    //2.设置keyWIndow的根控制器
    [UIApplication sharedApplication].keyWindow.rootViewController = v;
}

#pragma mark - 重写init方法(布局cell)
- (instancetype)init {
    //设置流布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.itemSize = kScreenBounds.size;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return [super initWithCollectionViewLayout:flowLayout];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ANMGuideCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    //传递显示的图片
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"guide_35_%@",@(indexPath.row + 1)]];
    
    cell.guideImage = image;
    
    return cell;
}
@end
