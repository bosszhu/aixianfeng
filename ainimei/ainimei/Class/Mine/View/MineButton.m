//
//  MineButton.m
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "MineButton.h"

@implementation MineButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 10);
    self.imageView.center = CGPointMake(midX, midY - 15);
    
}
@end
