//
//  MessageTableViewCell.h
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessageModel;

@interface MessageTableViewCell : UITableViewCell

/**
 是否显示显示全部按钮
 */
@property (weak, nonatomic) IBOutlet UILabel *showAllLable;
/**
 信息模型
 */
@property (nonatomic, strong) MessageModel *messageModel;

@end
