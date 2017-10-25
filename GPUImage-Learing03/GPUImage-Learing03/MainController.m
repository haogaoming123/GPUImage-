//
//  MainController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/19.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "MainController.h"

#define statutBarH  [UIApplication sharedApplication].statusBarFrame.size.height

@interface MainController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *mutArray;  //学习种类
@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mutArray = [NSMutableArray arrayWithObjects:@"GPUImage原生美颜",
                                                     @"利用美颜滤镜实现",
                                                     @"录制视频保存相册",
                                                     @"照片滤镜",nil];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, statutBarH, self.view.frame.size.width, 44)];
    topLabel.text = @"视频美颜学习";
    topLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:topLabel];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLabel.frame), self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    if (@available(iOS 11.0, *)) {
        tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
    }
    [self.view addSubview:tableview];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mutArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.text = self.mutArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (indexPath.row == 0) {
        [self.navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"ViewControllerID"] animated:true];
    }else if (indexPath.row == 1) {
        [self.navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"GPUImageBeautifyControllerID"] animated:true];
    }else if (indexPath.row == 2) {
        [self.navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"CameraSaveLibraryControllerID"] animated:true];
    }else if (indexPath.row == 3) {
        [self.navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"PhotoViewControllerID"] animated:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
