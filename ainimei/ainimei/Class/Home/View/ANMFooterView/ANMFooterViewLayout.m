//
//  ANMFooterViewLayout.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMFooterViewLayout.h"

//流布局对象
@implementation ANMFooterViewLayout

//准备布局时调用
-(void)prepareLayout{
    [super prepareLayout];
//    if(CGSizeEqualToSize(CGSizeZero, self.collectionView.bounds.size)) return;
    self.itemSize = CGSizeMake(([UIScreen mainScreen].bounds.size.width - 30)/2, ([UIScreen mainScreen].bounds.size.width - 30)/2 + 50);
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView.bounces = NO;
    
}

@end
