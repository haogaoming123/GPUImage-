//
//  ViewController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/19.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>

@interface ViewController ()

@property (nonatomic,strong) GPUImageVideoCamera *videoCamera;  //视频源
@property (nonatomic,strong) GPUImageBilateralFilter *bilateralFilter;  //磨皮滤镜
@property (nonatomic,strong) GPUImageBrightnessFilter *brightnessFilter;  //美白滤镜
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建视频源
    GPUImageVideoCamera *videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionFront];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera = videoCamera;
    
    //创建最终浏览view
    GPUImageView *captureVideoPreview = [[GPUImageView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:captureVideoPreview atIndex:0];
    
    //创建滤镜：磨皮，美白，组合滤镜
    GPUImageFilterGroup *groupFilter = [[GPUImageFilterGroup alloc] init];
    
    //磨皮滤镜
    GPUImageBilateralFilter *bilateralFilter = [[GPUImageBilateralFilter alloc] init];
    [groupFilter addTarget:bilateralFilter];
    self.bilateralFilter = bilateralFilter;
    
    //美白滤镜
    GPUImageBrightnessFilter *brightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    [groupFilter addTarget:brightnessFilter];
    self.brightnessFilter = brightnessFilter;
    
    //设置滤镜组链
    [bilateralFilter addTarget:brightnessFilter];
    [groupFilter setInitialFilters:@[bilateralFilter]];
    groupFilter.terminalFilter = brightnessFilter;
    
    //设置GPUImage响应链，从数据-->滤镜-->最终界面效果
    [videoCamera addTarget:groupFilter];
    [groupFilter addTarget:captureVideoPreview];
    
    //开始采集视频
    [videoCamera startCameraCapture];
}

/**
 停止录制

 @param sender 录制按钮
 */
- (IBAction)stopCamare:(UIButton *)sender {
    [self.videoCamera stopCameraCapture];
    
}

/**
 美白效果

 @param sender 美白滑块
 */
- (IBAction)brightnessFilter:(UISlider *)sender {
    self.brightnessFilter.brightness = sender.value;
}

/**
 磨皮效果

 @param sender 磨皮滑块
 */
- (IBAction)bilateralFilter:(UISlider *)sender {
    //值越小，磨皮效果越好
    CGFloat maxValue = 10;
    self.bilateralFilter.distanceNormalizationFactor = maxValue - sender.value;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
