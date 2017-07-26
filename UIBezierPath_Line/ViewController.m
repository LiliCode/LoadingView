//
//  ViewController.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/14.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "ViewController.h"
#import "ActivityView.h"
#import <MJRefresh.h>

static const NSTimeInterval __time_second = 2;    //单位 秒(s)
static const CGFloat transitionPoint = .5f;

FOUNDATION_STATIC_INLINE CGFloat ScreenWidth()
{
    return [UIScreen mainScreen].bounds.size.width;
}

FOUNDATION_STATIC_INLINE CGFloat ScreenHeight()
{
    return [UIScreen mainScreen].bounds.size.height;
}

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface ViewController ()<CAAnimationDelegate>
#else
@interface ViewController ()
#endif

@property (strong , nonatomic) CAShapeLayer *lineLayer; //绘制直线的leyer

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}


// t = 5
// s = v * t
// s1 = v1 * t
// s2 = v2 * t

// 第一阶段
// s11 = ScreenWidth * 1/3
// v11 = (ScreenWidth * 1/3) / t

// s12 = ScreenWidth * 2/3
// v12 = (ScreenWidth * 2/3) / t

// 第二阶段
// s21 = ScreenWidth * 2/3
// v21 = (ScreenWidth * 2/3) / t

// s22 = ScreenWidth * 1/3
// v22 = (ScreenWidth * 1/3) / t


- (void)animationOne
{
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration = __time_second * 2;
    strokeStartAnimation.fromValue = @0;
    strokeStartAnimation.toValue = @(1);
    strokeStartAnimation.delegate = self;
    strokeStartAnimation.repeatCount = INT_MAX;
    [strokeStartAnimation setRemovedOnCompletion:YES];
    [self.lineLayer addAnimation:strokeStartAnimation forKey:@"strokeStartAnimation_1"];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = __time_second;
    strokeEndAnimation.fromValue = @0;
    strokeEndAnimation.toValue = @(1);
    strokeEndAnimation.repeatCount = INT_MAX;
    [strokeEndAnimation setRemovedOnCompletion:YES];
    [self.lineLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation_1"];
}

- (void)animationTwo
{
    CABasicAnimation *strokeStartAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStartAnimation.duration = __time_second;
    strokeStartAnimation.fromValue = @(transitionPoint);
    strokeStartAnimation.toValue = @(1);
    [self.lineLayer addAnimation:strokeStartAnimation forKey:@"strokeStartAnimation_2"];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.duration = __time_second;
    strokeEndAnimation.fromValue = @(1 - transitionPoint);
    strokeEndAnimation.toValue = @(1);
    [self.lineLayer addAnimation:strokeEndAnimation forKey:@"strokeEndAnimation_3"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag)
    {
//        [self animationOne];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}


@end



