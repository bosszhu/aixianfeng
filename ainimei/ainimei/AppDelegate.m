//
//  AppDelegate.m
//  ainimei
//
//  Created by kingLee on 16/11/12.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "AppDelegate.h"
#import "ANMMainTabBarVc.h"
#import "ANMGuideCollectionViewController.h"
#import "AdvertiseView.h"
#import "PrefixHeader.pch"


#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"


// 引入JPush功能所需头文件
#import "JPUSHService.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

@interface AppDelegate ()<JPUSHRegisterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //远程推送功能
    [self remotePush];
    
    
    [JPUSHService setupWithOption:launchOptions
                           appKey:remotePushAppkey
                          channel:@"App Store"
                 apsForProduction:YES
            advertisingIdentifier:nil];
    
    //分享功能
     [self registShareSDK];
    
    
    self.window = [[UIWindow alloc]init];
    
    // 判断是否是新特性页
    [self isFirstShow];
    
    [self.window makeKeyAndVisible];

    [self isShowadvertiseView];
    
    
    return YES;
}

#pragma mark - ShareSDK分享
- (void)registShareSDK {
    NSArray *appArray = @[
                          @(SSDKPlatformTypeSinaWeibo),
                          @(SSDKPlatformTypeWechat),
                           @(SSDKPlatformTypeQQ),
                          ];
    [ShareSDK registerApp:@"ANM" activePlatforms:appArray onImport:^(SSDKPlatformType platformType) {
        //类型
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            case SSDKPlatformTypeSinaWeibo:
                [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                [appInfo SSDKSetupSinaWeiboByAppKey:WeiboAppKey
                                          appSecret:WeiboAppSecret
                                        redirectUri:@"http://www.baidu.com"
                                           authType:SSDKAuthTypeBoth];
                break;
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:WechatAppKey
                                      appSecret:WechatAppSecret];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:QQAppKey
                                     appKey:QQAppSecret
                                   authType:SSDKAuthTypeBoth];
                break;

            default:
                break;
        }
    }];
}


#pragma mark - 远程推送
- (void)remotePush {
    //Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    }
    else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert) categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

// 失败回调
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        // 做的事情通过userInfo获取服务器传过来的数据
        //做自己的事情
        [self doRemote];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        
        //做自己的事情
        [self doRemote];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required,For systems with less than or equal to iOS6
    [JPUSHService handleRemoteNotification:userInfo];
}

- (void)doRemote {
    NSLog(@"收到通知要做的事情");
}


#pragma mark - 启动页广告
- (void)isShowadvertiseView {
    //判断沙盒中是否存在广告图片
    //         1.判断沙盒中是否存在广告图片，如果存在，直接显示
    NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        
        AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
        
    }
    //        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage];
}
- (void)isFirstShow {
    // 1.获取当前版本号
    NSString *localVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    // 2.获取上一次app的版本
    NSString *upVersion = [[NSUserDefaults standardUserDefaults]objectForKey:@"bundleVersion"];
    
    // 3.显示不同的页面
    if ([localVersion isEqualToString:upVersion]) {
        //        正常显示
//        NSLog(@"正常显示控制器");
        ANMMainTabBarVc *v = [ANMMainTabBarVc new];
        self.window.rootViewController = v;
        //这里面加载广告页
//        //判断沙盒中是否存在广告图片
////         1.判断沙盒中是否存在广告图片，如果存在，直接显示
//        NSString *filePath = [self getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
//        
//        BOOL isExist = [self isFileExistWithFilePath:filePath];
//        if (isExist) {// 图片存在
//            
//            AdvertiseView *advertiseView = [[AdvertiseView alloc] initWithFrame:self.window.bounds];
//            advertiseView.filePath = filePath;
//            [advertiseView show];
//            
//        }
////        // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
//        [self getAdvertisingImage];
        
    } else {
        //创建新特性控制器
        ANMGuideCollectionViewController *guideVc = [[ANMGuideCollectionViewController alloc]init];
        self.window.rootViewController = guideVc;
    
        //把最新的版本号保存起来
        [[NSUserDefaults standardUserDefaults] setObject:localVersion forKey:@"bundleVersion"];
    }
}



/**
 *  判断文件是否存在
 */
- (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}

/**
 *  初始化广告页面
 */
- (void)getAdvertisingImage
{
    
    // TODO 请求广告接口
    
    // 这里原本采用美团的广告接口，现在了一些固定的图片url代替可以改商品图片
//    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg",@"http://img01.bqstatic.com/upload/activity/2016011111271981.jpg"];
    NSArray *imageArray = @[@"http://img01.bqstatic.com/upload/activity/2016011111271981.jpg",@"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    
    
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [self getFilePathWithImageName:imageName];
    BOOL isExist = [self isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
//            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
//            NSLog(@"保存失败");
        }
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

/**
 *  根据图片名拼接文件路径
 */
- (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:imageName];
        
        return filePath;
    }
    
    return nil;
}

@end
