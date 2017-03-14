//
//  PaySecondCell.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "PaySecondCell.h"

@interface PaySecondCell ()
@property (weak, nonatomic) IBOutlet UIButton *wechatPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqPayBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *huodaoBtn;

@property (nonatomic, weak) UIButton *lastBtn;

@end

@implementation PaySecondCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.wechatPayBtn.selected = YES;
    self.lastBtn = self.wechatPayBtn;
}
- (IBAction)didClickWechat:(UIButton *)sender {
    [self changeStateWithBtn:sender];
    
}
- (IBAction)didClickQQBtn:(UIButton *)sender {
    [self changeStateWithBtn:sender];
}
- (IBAction)didClickZhifuBtn:(UIButton *)sender {
    [self changeStateWithBtn:sender];
}
- (IBAction)didClickHuodaoBtn:(UIButton *)sender {
    [self changeStateWithBtn:sender];
}

-(void)changeStateWithBtn:(UIButton *)sender{
    if (sender.selected == YES) {
        return;
    }
    sender.selected = YES;
    self.lastBtn.selected = NO;
    self.lastBtn = sender;
}




@end
