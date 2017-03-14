//
//  ANMQRCodeViewController.m
//  我的项目二维码
//
//  Created by Huster on 2016/11/16.
//  Copyright © 2016年 Huster. All rights reserved.
//

#import "ANMQRCodeViewController.h"
#import "Masonry.h"
#import <AVFoundation/AVFoundation.h>
#import "CALayer+ZUtility.h"

@interface ANMQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,CAAnimationDelegate>
/** 捕获会话 */
@property (strong, nonatomic) AVCaptureSession *session;


@property (nonatomic,strong)UIImageView *line;

@property (nonatomic,strong) AVCaptureVideoPreviewLayer *scanLayer;

@end

@implementation ANMQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1. 摄像头  AVMediaTypeVideo
    AVCaptureDevice *video = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2.1 创建了输入端, 绑定了摄像头
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:video error:&error];
    if (error) {
        NSLog(@"创建输入端失败!");
        return;
    }
    // 1. 创建会话实例
    _session = [[AVCaptureSession alloc] init];
    
    // 2. 配置输入端
    if ([_session canAddInput:input] == NO) {
        NSLog(@"输入端添加失败!");
        return;
    }
    [_session addInput:input];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 2. 添加到会话当中
    if ([_session canAddOutput:output] == NO) {
        NSLog(@"输出端添加失败!");
        return;
    }
    // 添加输出端到会话当中
    [_session addOutput:output];
//    NSLog(@"%@", output.availableMetadataObjectTypes);
    
    for (NSString *type in output.availableMetadataObjectTypes) {
        printf("%s\n", [type cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    // 3.1 设置输出端当前要解析的数据类型
    output.metadataObjectTypes = @[@"org.iso.QRCode"];
    
    // 3.2 设置解析结果的数据回调, 让回调方法在指定的队列当中执行
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    CGFloat wh = 250;
    CGFloat width = wh / self.view.bounds.size.width;
    CGFloat height = wh / self.view.bounds.size.height;
    CGFloat x = (self.view.bounds.size.width - wh) * 0.5 / self.view.bounds.size.width;
    CGFloat y = (self.view.bounds.size.height - wh) * 0.5 / self.view.bounds.size.height;
    
    output.rectOfInterest = CGRectMake(y, x, height, width);
    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
//

    

    
    // 注意: 要配置frame值
    previewLayer.frame = self.view.bounds;
    // 添加预览图层
    [self.view.layer addSublayer:previewLayer];
    
    // ========== 添加遮盖 ==========
//        [self addCover];
    CGFloat coverX = (self.view.bounds.size.width - wh) * 0.5;
    CGFloat coverY = (self.view.bounds.size.height - wh) * 0.5;
    [self.view.layer coverButRect:CGRectMake(coverX, coverY, wh, wh)];
    _line = [UIImageView new];
    
        _line.image = [UIImage imageNamed:@"yellowlight.png"];
    
        _line.contentMode = UIViewContentModeScaleAspectFill;
    
        _line.backgroundColor = [UIColor clearColor];
    
        [self addAnimation];
    
        [self.view addSubview:_line];
        [_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(coverY);
    
            make.left.mas_equalTo(coverX);
    
            make.right.mas_equalTo(width-80);
            
            make.width.mas_equalTo(wh);
            
            make.height.mas_equalTo(2);
        }];
    
     // ========== 5. 启动会话 ==========
     // 开始运行!
//    [self setOverlayPickerView];
     [_session startRunning];

    
}
- (void)addCover
{
    // 用来绘制某些形状的图层, 由路径来决定
    CAShapeLayer *topLayer = [[CAShapeLayer alloc] init];
    // 配置矩形路径
    UIBezierPath *rect = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    topLayer.path = rect.CGPath;
    
    // 配置填充的颜色和透明度
    topLayer.fillColor = [UIColor lightGrayColor].CGColor;
    topLayer.opacity = 0.6;
    
    [self.view.layer addSublayer:topLayer];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

/**
 输出端捕获到指定的数据类型时触发
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    
    for (AVMetadataMachineReadableCodeObject *object in metadataObjects) {
        
        printf("%s", [object.stringValue cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    // 让会话停止
    [_session stopRunning];
}

- (void)setOverlayPickerView

{
    //左侧的view
    
    UIView *leftView = [UIView new];
    
    leftView.alpha = 0.5;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        
        make.bottom.equalTo(self.view.mas_bottom);
        
        make.left.equalTo(self.view.mas_left);
        
        make.width.mas_equalTo(30);
    }];
    
    
    
    
    //右侧的view
    
    UIView *rightView = [UIView new];
    
    rightView.alpha = 0.5;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        
        make.bottom.equalTo(self.view.mas_bottom);
        
        make.right.equalTo(self.view.mas_right);
        
        make.width.mas_equalTo(30);
    }];
    //最上部view
    
    UIView* upView = [UIView new];
    
    upView.alpha = 0.5;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:upView];
    [upView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        
        make.left.equalTo(leftView.mas_right);
        
        make.right.equalTo(rightView.mas_left);
        
        make.height.mas_equalTo(30);
    }];
    
   
    UIImageView *centerView = [UIImageView new];
    
    centerView.center = self.view.center;
    
    centerView.image = [UIImage imageNamed:@"scanFrame.png"];
    
    centerView.contentMode = UIViewContentModeScaleAspectFit;
    
    centerView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:centerView];
    
    
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_bottom);
        
        make.left.equalTo(leftView.mas_right);
        
        make.right.equalTo(rightView.mas_left);
        
        make.height.equalTo(upView.mas_width);
    }];
    
    
    
    _line = [UIImageView new];
    
    _line.image = [UIImage imageNamed:@"yellowlight.png"];
    
    _line.contentMode = UIViewContentModeScaleAspectFill;
    
    _line.backgroundColor = [UIColor clearColor];
    
    [self addAnimation];
    
    [self.view addSubview:_line];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(centerView.mas_top);
        
        make.left.mas_equalTo(centerView.mas_left);
        
        make.right.mas_equalTo(centerView.mas_right);
        
        make.height.mas_equalTo(2);
    }];
    
   
}
- (void)addAnimation{
   
    
    CABasicAnimation *animation = [self moveYTime:2 fromY:[NSNumber numberWithFloat:0] toY:[NSNumber numberWithFloat:250] rep:OPEN_MAX];
    
    
    
    [_line.layer addAnimation:animation forKey:@"animation"];
    
}

//动画设定
-(CABasicAnimation *)moveYTime:(float)time fromY:(NSNumber *)fromY toY:(NSNumber *)toY rep:(int)rep

{
    
    CABasicAnimation *animationMove = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    [animationMove setFromValue:fromY];
    
    [animationMove setToValue:toY];
    
    animationMove.duration = time;
    
    animationMove.delegate = self;
    
    animationMove.repeatCount  = rep;
    
    animationMove.fillMode = kCAFillModeForwards;
    
    animationMove.removedOnCompletion = NO;
    
    animationMove.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    return animationMove;
    
}


@end
