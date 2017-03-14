//
//  VipCollectionViewCell.m
//  ainimei
//
//  Created by user on 16/11/18.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "VipCollectionViewCell.h"
#import "UIView+HMObjcSugar.h"

@interface VipCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *smallView;

@end
@implementation VipCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.BigView.layer.cornerRadius = 10;
    self.BigView.layer.masksToBounds = YES;
    
    UIView *yelloView = [[UIView alloc]init];
    yelloView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:yelloView];
    yelloView.frame = CGRectMake(0,10 , 0, 7);
    self.yellowView = yelloView;
    
}

@end
