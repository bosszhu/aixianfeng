//
//  HMWeakTimerTargetObject.h
//  06-定时器的使用注意点-(掌握)
//
//  Created by HM on 16/9/9.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMWeakTimerTargetObject : NSObject

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo;
@end
