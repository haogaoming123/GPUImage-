//
//  GPUImageBeautifyController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/19.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "GPUImageBeautifyController.h"
#import <GPUImage.h>
#import "GPUImageBeautifyFilter.h"

@interface GPUImageBeautifyController ()

@property (nonatomic,strong) GPUImageVideoCamera *videoCamera;
@property (nonatomic,strong) GPUImageView *captureVideoPreview;
@end

@implementation GPUImageBeautifyController

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self stopCamare:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视频源
    GPUImageVideoCamera *camera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    camera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = camera;
    
    //创建最终浏览的view
    GPUImageView *view = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:view atIndex:0];
    self.captureVideoPreview = view;
    
    //设置处理链
    [camera addTarget:view];
    
    [camera startCameraCapture];
}

/**
 打开美颜滤镜

 @param sender swift
 */
- (IBAction)openBeautifyFilter:(UISwitch *)sender {
    if (sender.on) {
        //移除之前所有的处理链
        [self.videoCamera removeAllTargets];
        
        //创建美颜滤镜
        GPUImageBeautifyFilter *beautifyFilter = [[GPUImageBeautifyFilter alloc] init];
        
        //设置GPUImage处理链
        [self.videoCamera addTarget:beautifyFilter];
        [beautifyFilter addTarget:self.captureVideoPreview];
    }else{
        //移除之前所有处理链
        [self.videoCamera removeAllTargets];
        [self.videoCamera addTarget:self.captureVideoPreview];
    }
}
- (IBAction)stopCamare:(UIButton *)sender {
    [self.videoCamera stopCameraCapture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
