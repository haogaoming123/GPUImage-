//
//  MainController.m
//  GPUImage-Learing03
//
//  Created by haogaoming on 2017/10/19.
//  Copyright © 2017年 郝高明. All rights reserved.
//

#import "MainController.h"
#import "ViewController.h"

#define statutBarH  [UIApplication sharedApplication].statusBarFrame.size.height

@interface MainController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, statutBarH, self.view.frame.size.width, 44)];
    topLabel.text = @"视频美颜学习";
    topLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:topLabel];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLabel.frame), self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"GPUImage原生美颜";
    }else{
        cell.textLabel.text = @"利用美颜滤镜实现";
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        [self.navigationController pushViewController:[story instantiateViewControllerWithIdentifier:@"ViewControllerID"] animated:true];
    }else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
