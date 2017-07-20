//
//  RoundViewController.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/17.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "RoundViewController.h"
#import "ActivityView.h"
#import "RespireAnimationView.h"

@interface RoundViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (strong , nonatomic) ActivityView *loadingView;
@property (strong , nonatomic) RespireAnimationView *animationView;

@end

@implementation RoundViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loadingView = [[ActivityView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    self.loadingView.center = self.view.center;
    self.loadingView.lineWidth = 5.0f;
    //00CC99
    self.loadingView.strokeColor = [UIColor colorWithRed:0 green:193.0f/255.0f blue:156.0f/255.0f alpha:1];
    self.loadingView.progress = 0;
    
    [self.view addSubview:self.loadingView];
}

- (IBAction)start:(UIButton *)sender
{
    [self.loadingView startLoading];
    self.label.text = @"将要加载...";
}

- (IBAction)end:(UIButton *)sender
{
    [self.loadingView endLoading];
    self.label.text = @"停止动画";
}

- (IBAction)done:(UIBarButtonItem *)sender
{
    if (self.loadingView.status == ActivityViewStatusLoading)
    {
        self.loadingView.status = ActivityViewStatusCompleted;
    }
}


- (IBAction)slider:(UISlider *)sender
{
    if (sender.value >= 1.0f)
    {
        self.loadingView.status = ActivityViewStatusLoading;
        self.label.text = @"loading...";
    }
    else
    {
        self.loadingView.progress = sender.value;
    }
    
//    NSLog(@"Slider Value = %f", sender.value);
}

- (IBAction)respireBegin:(UIButton *)sender
{
    if (self.animationView)
    {
        return;
    }
    
    CGFloat width = 100;
    self.animationView = [[RespireAnimationView alloc] init];
    self.animationView.color = [UIColor colorWithRed:0 green:193.0f/255.0f blue:156.0f/255.0f alpha:1];
    self.animationView.radius = 5;
    self.animationView.duration = .6;
    self.animationView.pointCount = 6;
    self.animationView.spacing = width / self.animationView.pointCount;
    [self.animationView addAnimation];   //添加动画
    
    [self.view addSubview:self.animationView];
    self.animationView.frame = CGRectMake(100, self.view.bounds.size.height - 100, width, 20);
}

- (IBAction)beginAction:(UIButton *)sender
{
    [self.animationView startAnimation]; //开始动画
}

- (IBAction)stopActioin:(UIButton *)sender
{
    [self.animationView endAnimation];
}

- (void)dealloc
{
    [self.loadingView remove];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end


