//
//  ANMHeadView.m
//  ainimei
//
//  Created by Huster on 2016/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMHeadView.h"
#import "Masonry.h"

@interface ANMHeadView()
@property (nonatomic,strong) UILabel *titleView;
@end
@implementation ANMHeadView

+ (instancetype)headerCellWith:(UITableView *)tableView {
    ANMHeadView *headerCell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerCell == nil) {
        headerCell = [[ANMHeadView alloc]initWithReuseIdentifier:@"header"];
    }
    return headerCell;
}
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier])
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
        _titleView = [[UILabel alloc]init];
        _titleView.backgroundColor = [UIColor clearColor];
        _titleView.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
        _titleView.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:_titleView];
        [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.trailing.equalTo(self);
            make.bottom.equalTo(self);
            make.leading.equalTo(self).offset(10);
        }];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    self.titleView.text = title;
}
@end
