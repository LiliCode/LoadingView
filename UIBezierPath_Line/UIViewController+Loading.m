//
//  UIViewController+Loading.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/27.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UIViewController+Loading.h"
#import "ActivityView.h"
#import <objc/runtime.h>


static const char *kIndicatorView = "kIndicatorView";
static const char *kTextColor = "kTextColor";
static const char *kLoadStatus = "kLoadStatus";
static const char *kIndicatorViewStyle = "kIndicatorViewStyle";
static const char *kCallbackBlock = "kCallbackBlock";
static const char *kStatusLabel = "kStatusLabel";
static const char *kActivityIndicatorView = "kActivityIndicatorView";
static const char *kActivityView = "kActivityView";
static const char *kLoadingBackgroundView = "kLoadingBackgroundView";



#define INDICATOR_SIZE (100.0f)


@interface UIViewController ()
@property (copy , nonatomic) LoadingCallbackBlock callbackBlock;    //回调
@property (strong , nonatomic) UIView *loadingBackgroundView;       //背景视图
@property (strong , nonatomic) UIView *indicatorView;   //活动指示器的背景视图
@property (strong , nonatomic) UILabel *label;  //显示状态文字
@property (strong , nonatomic) UIActivityIndicatorView *activityIndicatorView;
@property (strong , nonatomic) ActivityView *loadingView;

@end

@implementation UIViewController (Loading)

- (void)setIndicatorView:(UIView *)indicatorView
{
    objc_setAssociatedObject(self, &kIndicatorView, indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)indicatorView
{
    return objc_getAssociatedObject(self, &kIndicatorView);
}

- (void)setLoading_textColor:(UIColor *)loading_textColor
{
    objc_setAssociatedObject(self, &kTextColor, loading_textColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)loading_textColor
{
    return objc_getAssociatedObject(self, &kTextColor);
}

- (void)setLoading_loadStatus:(LoadDataStatus)loading_loadStatus
{
    objc_setAssociatedObject(self, &kLoadStatus, @(loading_loadStatus), OBJC_ASSOCIATION_ASSIGN);
}

- (LoadDataStatus)loading_loadStatus
{
    return [objc_getAssociatedObject(self, &kLoadStatus) unsignedIntegerValue];
}

- (void)setLoading_indicatorStyle:(LoadingIndicatorStyle)loading_indicatorStyle
{
    objc_setAssociatedObject(self, &kIndicatorViewStyle, @(loading_indicatorStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (LoadingIndicatorStyle)loading_indicatorStyle
{
    return [objc_getAssociatedObject(self, &kIndicatorViewStyle) unsignedIntegerValue];
}

- (void)setCallbackBlock:(LoadingCallbackBlock)callbackBlock
{
    objc_setAssociatedObject(self, &kCallbackBlock, callbackBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (LoadingCallbackBlock)callbackBlock
{
    return objc_getAssociatedObject(self, &kCallbackBlock);
}

- (void)setLabel:(UILabel *)label
{
    objc_setAssociatedObject(self, &kStatusLabel, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)label
{
    return objc_getAssociatedObject(self, &kStatusLabel);
}

- (void)setLoadingView:(ActivityView *)loadingView
{
    objc_setAssociatedObject(self, &kActivityView, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ActivityView *)loadingView
{
    return objc_getAssociatedObject(self, &kActivityView);
}

- (void)setActivityIndicatorView:(UIActivityIndicatorView *)activityIndicatorView
{
    objc_setAssociatedObject(self, &kActivityIndicatorView, activityIndicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    return objc_getAssociatedObject(self, &kActivityIndicatorView);
}

- (void)setLoadingBackgroundView:(UIView *)loadingBackgroundView
{
    objc_setAssociatedObject(self, &kLoadingBackgroundView, loadingBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)loadingBackgroundView
{
    return objc_getAssociatedObject(self, &kLoadingBackgroundView);
}



- (void)prepareSubviews
{
    self.loadingBackgroundView = [[UIView alloc] init];
    self.loadingBackgroundView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.loadingBackgroundView];
    
    self.label = [[UILabel alloc] init];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.numberOfLines = 0;
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0)
    {
        self.label.font = [UIFont fontWithName:@"PingFang SC" size:16];
    }
    else
    {
        self.label.font = [UIFont systemFontOfSize:16];
    }
    
    self.indicatorView = [[UIView alloc] init];
    
    [self.loadingBackgroundView addSubview:self.label];
    [self.loadingBackgroundView addSubview:self.indicatorView];
    
    UIView *indicatorView = nil;
    switch (self.loading_indicatorStyle)
    {
        case LoadingIndicatorStyleSystem:
        {
            self.activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            self.activityIndicatorView.color = [UIColor grayColor];
            indicatorView = self.activityIndicatorView;
        } break;
        case LoadingIndicatorStyleAnnulus:
        {
            self.loadingView = [[ActivityView alloc] init];
            self.loadingView.strokeColor = [UIColor redColor];
            self.loadingView.lineWidth = 3.0f;
            self.loadingView.status = ActivityViewStatusLoading;
            self.loadingView.progress = 0;
            
            indicatorView = self.loadingView;
        } break;
        case LoadingIndicatorStyleCustom:
            
            break;
            
        default: break;
    }
    
    [self.indicatorView addSubview:indicatorView];
    
#if 0
    self.label.backgroundColor = [UIColor redColor];
    self.indicatorView.backgroundColor = [UIColor orangeColor];
#endif
}

- (void)placeSubviews
{
    self.loadingBackgroundView.frame = self.view.bounds;
    self.indicatorView.frame = CGRectMake(0, 0, INDICATOR_SIZE, INDICATOR_SIZE);
    self.indicatorView.center = CGPointMake(self.loadingBackgroundView.center.x, self.loadingBackgroundView.center.y - 20);
    self.label.frame = CGRectMake(8, self.indicatorView.center.y + (INDICATOR_SIZE / 2.0f) + 20, self.loadingBackgroundView.bounds.size.width - 16, 25);
    
    switch (self.loading_indicatorStyle)
    {
        case LoadingIndicatorStyleSystem:
            self.activityIndicatorView.frame = CGRectMake(0, 0, 80, 80);
            self.activityIndicatorView.center = CGPointMake(INDICATOR_SIZE/2.0f, INDICATOR_SIZE/2.0f);
            break;
        case LoadingIndicatorStyleAnnulus:
            self.loadingView.frame = CGRectMake(0, 0, 40, 40);
            self.loadingView.center = CGPointMake(INDICATOR_SIZE/2.0f, INDICATOR_SIZE/2.0f);
            break;
        case LoadingIndicatorStyleCustom:
            
            break;
            
        default: break;
    }
}


- (void)showStatusText:(NSString *)text loadingStyle:(LoadingIndicatorStyle)loadingStyle click:(LoadingCallbackBlock)clickBlock
{
    self.callbackBlock = clickBlock;
    self.loading_indicatorStyle = loadingStyle;
    [self prepareSubviews];
    [self placeSubviews];
    [self makeText:text loadingStyle:loadingStyle];
}



- (void)makeText:(NSString *)text loadingStyle:(LoadingIndicatorStyle)loadingStyle
{
    self.label.text = text;
    
    switch (loadingStyle)
    {
        case LoadingIndicatorStyleSystem:
            [self.activityIndicatorView startAnimating];
            break;
        case LoadingIndicatorStyleAnnulus:
            [self.loadingView startLoading];
            break;
        case LoadingIndicatorStyleCustom:
            
            break;
            
        default: break;
    }
}



- (void)hideLoading
{
    
}




@end




