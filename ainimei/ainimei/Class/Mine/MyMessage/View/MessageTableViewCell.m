//
//  MessageTableViewCell.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MessageModel.h"

@interface MessageTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *contentLable;


@end
@implementation MessageTableViewCell

- (void)setMessageModel:(MessageModel *)messageModel {
    _messageModel = messageModel;
    
    
    self.titleLable.text = messageModel.title;
    self.contentLable.text = messageModel.content;
    
    
    // 怎么根据内容判断你的行高显示不同的内容.
//     NSLog(@"%zd",self.contentLable.numberOfLines);
//    if (self.contentLable.numberOfLines <= 2) {
//        self.showAllLable.hidden = YES;
//    }
}


@end
