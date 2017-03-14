//
//  ANMOrderStatusCell.m
//  ainimei
//
//  Created by kingLee on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMOrderStatusCell.h"

@interface ANMOrderStatusCell()
//事件轴
@property (nonatomic, weak) UILabel *timeLabel;

//状态描述
@property (nonatomic, weak) UILabel *discLabel;

//底部的分隔线
@property (nonatomic, weak) UIView *lineView;


@end

@implementation ANMOrderStatusCell

//初始化
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}


//增加控件
-(void)setupUI{
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:13];
    timeLabel.textColor = [UIColor lightGrayColor];
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    
    UILabel *statusLabel = [UILabel new];
    statusLabel.font = [UIFont systemFontOfSize:14];
    statusLabel.textColor = [UIColor lightGrayColor];
    self.statusLabel = statusLabel;
    [self addSubview:statusLabel];
    
    UILabel *discLabel = [UILabel new];
    discLabel.font = [UIFont systemFontOfSize:13];
    discLabel.textColor = [UIColor lightGrayColor];
    self.discLabel = discLabel;
    [self addSubview:discLabel];
    
    UIView *lineView= [UIView new];
    self.lineView = lineView;
    lineView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.00];
    [self addSubview: lineView];
    
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"order_grayMark"]];
    self.iconView = iconView;
    [self addSubview:iconView];
    
    UIView *upView= [UIView new];
    self.upView = upView;
    upView.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    [self addSubview: upView];
    
    UIView *lowerView= [UIView new];
    self.lowerView = lowerView;
    lowerView.backgroundColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
    [self addSubview: lowerView];
    
}


//设置位置
-(void)layoutSubviews{
    [super layoutSubviews];
    self.timeLabel.frame = CGRectMake(5, 5, 40, 25);
    self.statusLabel.frame = CGRectMake(80, 5, 120, 28);
    self.discLabel.frame = CGRectMake(80, 45, 200, 15);
    self.lineView.frame = CGRectMake(80, 69, [UIScreen mainScreen].bounds.size.width - 90, 1);
    self.iconView.frame = CGRectMake(50, 10, 15, 15);
    self.upView.frame = CGRectMake(56, 0, 3, 10);
    self.lowerView.frame = CGRectMake(56, 25, 3, 45);
}

//设置内容
-(void)setTimeline:(ANMTimelineModel *)timeline{
    _timeline = timeline;
    self.timeLabel.text = timeline.status_time;
    self.statusLabel.text = timeline.status_title;
    self.discLabel.text = timeline.status_desc;
}


@end
