//
//  MineHeadView.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "MineHeadView.h"

@interface MineHeadView ()
@property (weak, nonatomic) IBOutlet UIView *myInfo;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end
@implementation MineHeadView

+ (instancetype)loadHeadView {
    
    return [[[NSBundle mainBundle]loadNibNamed:@"MineHeadView" owner:self options:nil]lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.myInfo.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_my_avatar_bg"]];
    
    self.iconView.layer.cornerRadius = 35;
    self.iconView.layer.masksToBounds = YES;
}

- (IBAction)didMineAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(mineHeadViewDidButton:)]) {
        //执行
        [self.delegate mineHeadViewDidButton:sender];
    }
}

@end
