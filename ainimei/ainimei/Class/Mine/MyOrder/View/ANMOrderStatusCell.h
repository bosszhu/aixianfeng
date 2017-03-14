//
//  ANMOrderStatusCell.h
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ANMTimelineModel.h"

@interface ANMOrderStatusCell : UITableViewCell
//可改变的属性
//状态
@property (nonatomic, weak) UILabel *statusLabel;
//状态图片
@property (nonatomic, weak) UIImageView *iconView;
//上部的竖线
@property (nonatomic, weak) UIView *upView;
//下部的竖线
@property (nonatomic, weak) UIView *lowerView;

@property (nonatomic, strong) ANMTimelineModel * timeline;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
