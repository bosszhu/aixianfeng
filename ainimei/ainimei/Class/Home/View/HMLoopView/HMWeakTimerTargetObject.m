//
//  HMWeakTimerTargetObject.m
//  06-定时器的使用注意点-(掌握)
//
//  Created by HM on 16/9/9.
//  Copyright © 2016年 itheima. All rights reserved.
//

#import "HMWeakTimerTargetObject.h"

@interface HMWeakTimerTargetObject()
/**
 *  真正的目标对象
 */
@property (nonatomic, weak) id aTarget;
/**
 *  真正要执行的回调方法
 */
@property (nonatomic, assign) SEL aSelector;
@end

@implementation HMWeakTimerTargetObject

// aTarget ==> VC
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo {
    // 创建当前类对象
    HMWeakTimerTargetObject *obj = [[HMWeakTimerTargetObject alloc] init];
    obj.aTarget = aTarget;
    obj.aSelector = aSelector;
    
    return [NSTimer scheduledTimerWithTimeInterval:ti target:obj selector:@selector(fire:) userInfo:userInfo repeats:yesOrNo];
}

/**
 *  定时器回调方法
 */
- (void)fire:(NSTimer *)timer{
//    NSLog(@"%s", __FUNCTION__);
    [self.aTarget performSelector:self.aSelector withObject:timer];
}


@end
