//
//  VipTableViewCell.h
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VipModel;

@interface VipTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (nonatomic, strong) VipModel *model;
// 自定义cell的行高(计算不了Lable的高度啊)
@property (assign, nonatomic) CGFloat rowHeight;


@property (nonatomic, assign,getter=isSelected) BOOL selected;
@end
