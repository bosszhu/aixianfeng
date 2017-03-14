//
//  VipCollectionViewCell.h
//  ainimei
//
//  Created by user on 16/11/18.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VipCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *BigView;
@property (weak, nonatomic) IBOutlet UILabel *cellLable;

@property (nonatomic, strong) UIView *yellowView;
@end
