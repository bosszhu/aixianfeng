//
//  ANMHomeBtn.m
//  ainimei
//
//  Created by kingLee on 16/11/13.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMHomeBtn.h"

@implementation ANMHomeBtn

//用于重新定义btn里的title和image的位置
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(12, 12, 45, 30);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    return CGRectMake(0, 45, contentRect.size.width, 20);
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
