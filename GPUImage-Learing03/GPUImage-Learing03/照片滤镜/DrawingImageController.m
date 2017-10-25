//
//  DrawingImageController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/25.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "DrawingImageController.h"
#import <GPUImage.h>

@interface DrawingImageController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong,nonatomic) NSArray *textArray;
@property (strong,nonatomic) NSIndexPath *lastIndexPath;
@end

@implementation DrawingImageController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textArray = @[@"中间突出，四周黑暗",@"红色",@"怀旧",@"饱和",@"亮度",@"模糊"];
    self.imageview.image = self.image;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

/**
 点击返回

 @param sender 返回
 */
- (IBAction)backButtonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 点击下一步

 @param sender 按钮
 */
- (IBAction)nextButtonClick:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"finshImageNotifiation" object:self.imageview.image];
    [self dismissViewControllerAnimated:true completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 6;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = self.textArray[indexPath.row];
    label.backgroundColor = [UIColor whiteColor];
    cell.backgroundView = label;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.lastIndexPath == indexPath) {
        return;
    }
    self.imageview.image = [self hightLightImage:self.image with:indexPath.row];
    UICollectionViewCell *lastCell = [collectionView cellForItemAtIndexPath:self.lastIndexPath];
    lastCell.backgroundView.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundView.backgroundColor = [UIColor colorWithRed:1.0f green:0.27f blue:0.27f alpha:0.6];
    
    self.lastIndexPath = indexPath;
}

/**
 添加滤镜
 */
- (UIImage *)hightLightImage:(UIImage *)image with:(NSInteger)type {
    switch (type) {
        case 0:{
            //中间突出，四周黑暗
            GPUImageVignetteFilter *filter = [[GPUImageVignetteFilter alloc] init];
            [filter forceProcessingAtSize:image.size];
            [filter useNextFrameForImageCapture];
            
            GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:image];
            [source addTarget:filter];
            [source processImage];
            
            UIImage *fillName = [filter imageFromCurrentFramebuffer];
            return fillName;
        }break;
        case 1:{
            //红色
            GPUImageRGBFilter *filter = [[GPUImageRGBFilter alloc] init];
            filter.red = 0.9;
            filter.green = 0.8;
            filter.blue = 0.9;
            [filter forceProcessingAtSize:image.size];
            [filter useNextFrameForImageCapture];
            
            GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:image];
            [source addTarget:filter];
            [source processImage];
            
            UIImage *fillName = [filter imageFromCurrentFramebuffer];
            return fillName;
        }break;
        case 2:{
            //怀旧
            GPUImageSepiaFilter *filter = [[GPUImageSepiaFilter alloc] init];
            [filter forceProcessingAtSize:image.size];
            [filter useNextFrameForImageCapture];
            
            GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:image];
            [source addTarget:filter];
            [source processImage];
            
            UIImage *fillName = [filter imageFromCurrentFramebuffer];
            return fillName;
        }break;
        case 3:{
            //饱和
            GPUImageSaturationFilter *filter = [[GPUImageSaturationFilter alloc] init];
            filter.saturation = 1.6;
            [filter forceProcessingAtSize:image.size];
            [filter useNextFrameForImageCapture];
            
            GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:image];
            [source addTarget:filter];
            [source processImage];
            
            UIImage *fillName = [filter imageFromCurrentFramebuffer];
            return fillName;
        }break;
        case 4:{
            //亮度
            GPUImageBrightnessFilter *filter = [[GPUImageBrightnessFilter alloc] init];
            filter.brightness = 0.2;
            [filter forceProcessingAtSize:image.size];
            [filter useNextFrameForImageCapture];
            
            GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:image];
            [source addTarget:filter];
            [source processImage];
            
            UIImage *fillName = [filter imageFromCurrentFramebuffer];
            return fillName;
        }break;
        case 5:{
            //模糊
            GPUImageiOSBlurFilter *filter = [[GPUImageiOSBlurFilter alloc] init];
            filter.blurRadiusInPixels = 1.0f;
            [filter forceProcessingAtSize:image.size];
            [filter useNextFrameForImageCapture];
            
            GPUImagePicture *source = [[GPUImagePicture alloc] initWithImage:image];
            [source addTarget:filter];
            [source processImage];
            
            UIImage *fillName = [filter imageFromCurrentFramebuffer];
            return fillName;
        }break;
        default:
            return nil;
            break;
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
