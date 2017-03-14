//
//  SystemMessageView.m
//  ainimei
//
//  Created by user on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "SystemMessageView.h"

@implementation SystemMessageView

+ (instancetype)loadSystemMessageView {
    return [[[NSBundle mainBundle]loadNibNamed:@"SystemMessage" owner:self options:nil]lastObject];
}

@end
