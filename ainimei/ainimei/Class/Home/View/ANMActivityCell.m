//
//  ANMActivityCell.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMActivityCell.h"
#import <UIImageView+WebCache.h>

//此cell用于显示活动
@interface ANMActivityCell ()

//cell的大图
@property (nonatomic, weak) UIImageView *myImageView;
@end

@implementation ANMActivityCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

-(void)setupUI{
    UIImageView *myImageView = [[UIImageView alloc]init];
    [self addSubview:myImageView];
    self.myImageView = myImageView;
}

-(void)setActModel:(ANMActivityModel *)actModel{
    _actModel = actModel;
    [self.myImageView sd_setImageWithURL:[NSURL URLWithString:_actModel.img]];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.myImageView.frame = CGRectMake(10, 5, self.bounds.size.width -20, self.bounds.size.height -10);
}

@end
