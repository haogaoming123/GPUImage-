//
//  PhotoViewController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/25.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "PhotoViewController.h"

@interface PhotoViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageview;    //选择后的照片

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/**
 选择相册

 @param sender 按钮
 */
- (IBAction)selectPhotoButton:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self.navigationController pushViewController:picker animated:true];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
   
    //保存到系统相册
//        UIImageWriteToSavedPhotosAlbum(portraitImg, nil, nil, nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
