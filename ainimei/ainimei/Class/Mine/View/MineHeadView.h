//
//  MineHeadView.h
//  ainimei
//
//  Created by user on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MineHeadViewDelegate <NSObject>

- (void)mineHeadViewDidButton:(UIButton *)sender;

@end

@interface MineHeadView : UIView

@property (nonatomic, weak) id<MineHeadViewDelegate> delegate;

+ (instancetype)loadHeadView;


@end
