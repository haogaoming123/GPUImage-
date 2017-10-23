//
//  CameraSaveLibraryController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/19.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "CameraSaveLibraryController.h"
#import <GPUImage.h>
#import "GPUImageBeautifyFilter.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface CameraSaveLibraryController ()

@property (weak, nonatomic) IBOutlet UILabel *timeCountLabel;   //录制时间label

@property (weak, nonatomic) IBOutlet UIButton *startOrStopeBtn; //开始录制按钮

@property (nonatomic,strong) GPUImageVideoCamera *videoCamera;  //视频源

@property (nonatomic,strong) GPUImageView *captureVideoPreview; //视频最终显示的view

@property (nonatomic,strong) GPUImageMovieWriter *movieWriter;  //视频写入资源

@property (nonatomic,strong) GPUImageBeautifyFilter *beautifyFilter;    //美颜滤镜

@property (nonatomic,assign) int labelTime; //录制时间

@property (nonatomic,strong) NSTimer *timer;    //定时器

@end

@implementation CameraSaveLibraryController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视频源
    GPUImageVideoCamera *camera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    [camera addAudioInputsAndOutputs];  //解决视频录制的时候闪一下问题
    camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = camera;
    
    //创建最终浏览的view
    GPUImageView *view = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:view atIndex:0];
    self.captureVideoPreview = view;
    
    //创建美颜滤镜
    GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
    self.beautifyFilter = beautifyFilter;
    
    //设置GPUImage处理链
    [self.videoCamera addTarget:beautifyFilter];
    [beautifyFilter addTarget:self.captureVideoPreview];
    [camera startCameraCapture];
    
    //设置视频的采集方向
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidChangeStatusBarFrameNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        camera.outputImageOrientation = [UIApplication sharedApplication].statusBarOrientation;
    }];
}

/**
 录制/停止按钮点击事件

 @param sender 按钮
 */
- (IBAction)buttonClick:(UIButton *)sender {
    //视频保存地址
    NSString *pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie4.m4v"];
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    
    if ([sender.currentTitle isEqualToString:@"录制"]) {
        [sender setTitle:@"结束" forState:UIControlStateNormal];
        //如果已经存在文件，则删除旧文件
        unlink([pathToMovie UTF8String]);
        
        self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:self.view.frame.size];
        self.movieWriter.encodingLiveVideo = YES;
        [self.beautifyFilter addTarget:self.movieWriter];
        self.videoCamera.audioEncodingTarget = self.movieWriter;
        [self.movieWriter startRecording];
        
        //开启定时器记录录制时间
        self.labelTime = 0;
        self.timeCountLabel.hidden = NO;
        [self onTimer];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
    }else{
        [sender setTitle:@"录制" forState:UIControlStateNormal];
        self.timeCountLabel.hidden = YES;
        [self stopTimer];
        
        [self.beautifyFilter removeTarget:self.movieWriter];
        self.videoCamera.audioEncodingTarget = nil;
        [self.movieWriter finishRecording];
        
        //视频存储到本地相册
        [self saveLibrary:movieURL pathToMovie:pathToMovie];
    }
}

/**
 停止定时器
 */
- (void)stopTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

/**
 开启定时器
 */
- (void)onTimer {
    self.timeCountLabel.text = [NSString stringWithFormat:@"录制时间:%d秒",self.labelTime++];
}

/**
 前后摄像头切换

 @param sender 摄像头button
 */
- (IBAction)chengCamare:(UIButton *)sender {
    [self.videoCamera rotateCamera];
}

/**
 视频存储本地相册

 @param movieURL 视频URL
 */
- (void)saveLibrary:(NSURL *)movieURL pathToMovie:(NSString *)moviePath {
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
        [library writeVideoAtPathToSavedPhotosAlbum:movieURL completionBlock:^(NSURL *assetURL, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存失败" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                    [alert show];
                }else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"视频保存成功" message:nil delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
                    [alert show];
                }
            });
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
