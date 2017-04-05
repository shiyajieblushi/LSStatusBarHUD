//
//  ViewController.m
//  LSStatusBarHUDExample
//
//  Created by Yajie Shi on 2017/4/5.
//  Copyright © 2017年 Yajie Shi. All rights reserved.
//

#import "ViewController.h"
#import "LSStatusBarHUD.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)success:(id)sender {
    [LSStatusBarHUD showSuccess:@"加载成功！"];
}

- (IBAction)error:(id)sender {
    [LSStatusBarHUD showError:@"加载失败"];
    
}

- (IBAction)loading:(id)sender {
    [LSStatusBarHUD showLoading:@"加载中..."];
}

- (IBAction)hide:(id)sender {
    [LSStatusBarHUD hide];
}

- (IBAction)progress:(id)sender {
    [LSStatusBarHUD showLoadingProgress];
}

static CGFloat progress_;
// 模拟加载进度
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    progress_ = progress_ + 0.1;
    [LSStatusBarHUD loadingProgress:progress_];
}

@end
