//
//  SettingTableViewController.m
//  ainimei
//
//  Created by user on 16/11/16.
//  Copyright © 2016年 kingLee. All rights reserved.
//

#import "SettingTableViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface SettingTableViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *cacheLable;

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   //获取沙盒缓存显示到
    self.cacheLable.text = @"0M";
//    [self showCacheStr];
    
    NSString *str = [self getCacheSize];
    NSLog(@"%@",str);
    self.cacheLable.text = str;
}

#pragma mark - 显示缓存内容

#pragma mark - 计算缓存大小

- (NSString *)getCacheSize
{
    //定义变量存储总的缓存大小
    long long sumSize = 0;
    
    //01.获取当前缓存路径
    NSString *cacheFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    
    //02.创建文件管理对象
    NSFileManager *filemanager = [NSFileManager defaultManager];
    
    //获取当前缓存路径下的所有子路径
    NSArray *subPaths = [filemanager subpathsOfDirectoryAtPath:cacheFilePath error:nil];
    
    //遍历所有子文件
    for (NSString *subPath in subPaths) {
        //1）.拼接完整路径
        NSString *filePath = [cacheFilePath stringByAppendingFormat:@"/%@",subPath];
        //2）.计算文件的大小
        long long fileSize = [[filemanager attributesOfItemAtPath:filePath error:nil]fileSize];
        //3）.加载到文件的大小
        sumSize += fileSize;
    }
    float size_m = sumSize/(1024.0*1024.0);
    return [NSString stringWithFormat:@"%.2fM",size_m];
    
}

// 这种计算会有内存泄漏
//- (void)showCacheStr{
//   NSString *pathStr = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
//    
//    float folderSize;    NSFileManager *fileManager = [NSFileManager defaultManager];
//    if ([fileManager fileExistsAtPath:pathStr]) {
//        //拿到文件数组
//        NSArray *childFiles = [fileManager subpathsAtPath:pathStr];
//        for (NSString *fileName in childFiles) {
//            //将路径拼接到一起
//            NSString *fullPath = [pathStr stringByAppendingPathComponent:fileName];
//            folderSize += [self fileSizeAtPath:fullPath];
//        }
//    }
//
//    self.cacheLable.text = [NSString stringWithFormat:@"%.2fM",folderSize];
//}

//计算单个文件夹的大小
-(float)fileSizeAtPath:(NSString *)path{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    if([fileManager fileExistsAtPath:path]){
        
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        
        return size/1024.0/1024.0;
    }
    return 0;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
//        NSLog(@"分享");
        [self showShareSDK];
        //自定义分享界面
    } else if (indexPath.row == 1) {
//        NSLog(@"关于我们");
        //跳转
        UIStoryboard *MMSB = [UIStoryboard storyboardWithName:@"MM" bundle:nil];
        //创建控制器
        UIViewController *MMVc = [MMSB instantiateInitialViewController];
        [self.navigationController pushViewController:MMVc animated:YES];
        
    } else {
//        NSLog(@"清除缓存");
        //弹出提示框
        UIAlertView *deleteAlertView = [[UIAlertView alloc]initWithTitle:@"确定要清除缓存吗?" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [deleteAlertView show];
    }
}
#pragma mark - 分享界面
- (void)showShareSDK {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"分享到" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    __weak typeof(alert) wAlert = alert;
    [wAlert addAction:[UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        
        
    }]];
    [wAlert addAction:[UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        
        
    }]];
    [wAlert addAction:[UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 点击确定按钮的时候, 会调用这个block
        [self showWeiboShare];
        
    }]];
    [wAlert addAction:[UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
//        NSLog(@"%@",[wAlert.textFields.firstObject text]);
        
    }]];
    
    [wAlert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:wAlert animated:YES completion:nil];
}
#pragma mark - 分享实现
- (void)showWeiboShare {
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"MM"]];
//    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"ANM小组牛不牛"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://www.jianshu.com/users/5ad33f76b079/latest_articles"]
                                          title:@"ANNM牛牛牛"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        //输出数据,跳转控制器
        //block回传数据
        //修改Lable为0
        self.cacheLable.text = @"0M";
    }
}
@end
