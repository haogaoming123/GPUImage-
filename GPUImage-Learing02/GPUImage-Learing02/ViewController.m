//
//  ViewController.m
//  GPUImage-Learing02
//
//  Created by haogaoming on 2017/10/18.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "ViewController.h"
#import <GPUImage.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *inputImage = [UIImage imageNamed:@"60"];
    //使用黑白素描滤镜
    GPUImageSmoothToonFilter *disFilter = [[GPUImageSmoothToonFilter alloc] init];
    disFilter.blurRadiusInPixels = 0.5;
    //设置渲染区域
    [disFilter forceProcessingAtSize:inputImage.size];
    [disFilter useNextFrameForImageCapture];
    
    //获取数据来源
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:inputImage];
    
    //添加上滤镜
    [stillImageSource addTarget:disFilter];
    //开始渲染
    [stillImageSource processImage];
    //获取渲染后的图片
    UIImage *newImage = [disFilter imageFromCurrentFramebuffer];
    //加载出来
    UIImageView *imagview = [[UIImageView alloc] initWithImage:newImage];
    imagview.frame = CGRectMake(100, 100, inputImage.size.width, inputImage.size.height);
    [self.view addSubview:imagview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
