//
//  XMGStatusBarHUD.m
//  04-XMGStatusBarHUD
//
//  Created by xiaomage on 15/7/30.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "LSStatusBarHUD.h"

#define XMGMessageFont [UIFont systemFontOfSize:12]

/** 消息的停留时间 */
static CGFloat const XMGMessageDuration = 2.0;
/** 消息显示\隐藏的动画时间 */
static CGFloat const XMGAnimationDuration = 0.25;

@implementation LSStatusBarHUD

/** 全局的窗口 */
static UIWindow *window_;
/** 定时器 */
static NSTimer *timer_;
/** 进度条 */
static UIProgressView *progressView_;

/**
 * 显示窗口
 */
+ (void)showWindow
{
    // frame数据
    CGFloat windowH = 20;
    CGRect frame = CGRectMake(0, - windowH, [UIScreen mainScreen].bounds.size.width, windowH);
    
    // 显示窗口
    window_.hidden = YES;
    window_ = [[UIWindow alloc] init];
    window_.backgroundColor = [UIColor blackColor];
    window_.windowLevel = UIWindowLevelAlert;
    window_.frame = frame;
    window_.hidden = NO;
    
    // 动画
    frame.origin.y = 0;
    [UIView animateWithDuration:XMGAnimationDuration animations:^{
        window_.frame = frame;
    }];
}

/**
 * 显示普通信息
 * @param msg       文字
 * @param image     图片
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    // 停止定时器
    [timer_ invalidate];
    
    // 显示窗口
    [self showWindow];
    
    // 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:msg forState:UIControlStateNormal];
    button.titleLabel.font = XMGMessageFont;
    if (image) { // 如果有图片
        [button setImage:image forState:UIControlStateNormal];
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    }
    button.frame = window_.bounds;
    [window_ addSubview:button];
    
    // 定时器
    timer_ = [NSTimer scheduledTimerWithTimeInterval:XMGMessageDuration target:self selector:@selector(hide) userInfo:nil repeats:NO];
}

/**
 * 显示普通信息
 */
+ (void)showMessage:(NSString *)msg
{
    [self showMessage:msg image:nil];
}

/**
 * 显示成功信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"LSStatusBarHUD.bundle/success"]];
}

/**
 * 显示失败信息
 */
+ (void)showError:(NSString *)msg
{
    [self showMessage:msg image:[UIImage imageNamed:@"LSStatusBarHUD.bundle/error"]];
}

/**
 * 显示正在处理的信息
 */
+ (void)showLoading:(NSString *)msg
{
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    // 显示窗口
    [self showWindow];
    
    // 添加文字
    UILabel *label = [[UILabel alloc] init];
    label.font = XMGMessageFont;
    label.frame = window_.bounds;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    [window_ addSubview:label];
    
    // 添加圈圈
    UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [loadingView startAnimating];
    // 文字宽度
    CGFloat msgW = [msg sizeWithAttributes:@{NSFontAttributeName : XMGMessageFont}].width;
    CGFloat centerX = (window_.frame.size.width - msgW) * 0.5 - 20;
    CGFloat centerY = window_.frame.size.height * 0.5;
    loadingView.center = CGPointMake(centerX, centerY);
    [window_ addSubview:loadingView];
}

/**
 * 显示正在加载进度(带进度条)
 */
+ (void)showLoadingProgress{
    
    // 停止定时器
    [timer_ invalidate];
    timer_ = nil;
    
    progressView_ = nil;
    window_ = nil;
    // 显示窗口
    [self showWindow];
    
    window_.backgroundColor = [UIColor clearColor];
    
    progressView_ = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 18, [UIScreen mainScreen].bounds.size.width, 2)];
    [window_ addSubview:progressView_];
    progressView_.backgroundColor = [UIColor lightGrayColor];
    progressView_.progressTintColor = [UIColor redColor];
    progressView_.progress = 0;
}

/**
 * 修改进度
 */
+ (void)loadingProgress:(CGFloat)progres{
    
    progressView_.progress = progres;
    if(progres >= 1.0){
        [self hide];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(XMGAnimationDuration * 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [LSStatusBarHUD showSuccess:@"加载成功!"];
        });
    }
}
/**
 * 隐藏
 */
+ (void)hide
{
    [UIView animateWithDuration:XMGAnimationDuration animations:^{
        CGRect frame = window_.frame;
        frame.origin.y =  - frame.size.height;
        window_.frame = frame;
    } completion:^(BOOL finished) {
        window_ = nil;
        timer_ = nil;
    }];
}


+ (void)showXXX
{
    
}
@end