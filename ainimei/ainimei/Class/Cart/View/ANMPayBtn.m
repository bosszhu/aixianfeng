//
//  ANMPayBtn.m
//  ainimei
//
//  Created by kingLee on 16/11/15.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "ANMPayBtn.h"

@implementation ANMPayBtn

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    return CGRectMake(self.bounds.size.width -40, (self.bounds.size.height - 20)/2, 20, 20);
}

@end
