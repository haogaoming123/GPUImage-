//
//  DrawingImageController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/25.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "DrawingImageController.h"

@interface DrawingImageController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewCell *collectionCell;

@end

@implementation DrawingImageController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 点击返回

 @param sender 返回
 */
- (IBAction)backButtonClick:(UIButton *)sender {
}

/**
 点击下一步

 @param sender 按钮
 */
- (IBAction)nextButtonClick:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
