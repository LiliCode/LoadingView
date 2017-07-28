//
//  EmptyDataController.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/28.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "EmptyDataController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "ActivityView.h"

@interface EmptyDataController ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>
@property (weak , nonatomic) UIScrollView *scrollView;
@property (strong , nonatomic) UIView *imageView;

@end

@implementation EmptyDataController

+ (instancetype)emptyData:(UIScrollView *__weak)scollView
{
    return [[self alloc] initWithEmptyData:scollView];
}

- (instancetype)initWithEmptyData:(UIScrollView *__weak)scollView
{
    if (self = [super init])
    {
        self.scrollView = scollView;
        self.scrollView.emptyDataSetSource = self;
        self.scrollView.emptyDataSetDelegate = self;
        self.verticalOffset = -64.0f;
    }
    
    return self;
}

- (void)reloadEmptyData
{
    [self.scrollView reloadEmptyDataSet];
}

#pragma DZNEmptyDataSetSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (LoadDataStatusFailed == self.loadStatus)
    {
        return self.networkErrorImage;
    }
    else if (LoadDataStatusEmptyData == self.loadStatus)
    {
        return self.emptyDataImage;
    }
    
    return nil;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (LoadDataStatusFailed == self.loadStatus)
    {
        return nil;
    }
    
    return self.titleText;
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    if (LoadDataStatusFailed == self.loadStatus)
    {
        return nil;
    }
    
    return self.detailText;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    if (LoadDataStatusFailed == self.loadStatus)
    {
        NSString *text = @"网络不给力，请点击重试哦~";
        UIFont *font = [UIFont systemFontOfSize:14.0];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, text.length)];
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, text.length)];
        [attStr addAttribute:NSForegroundColorAttributeName value:[self hexColor:@"#31B3EE"] range:NSMakeRange(7, 4)];
        return attStr;
    }
    
    return self.buttonTitle;
}

- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    return self.buttonBackgroundImage;
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.backgroundColor;
}

/**
 *  设置垂直方向的偏移量 （推荐使用）
 */
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return self.verticalOffset;
}

- (void)emptyDataSetWillAppear:(UIScrollView *)scrollView
{
    self.scrollView.contentOffset = CGPointZero;
}


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    if (LoadDataStatusLoading == self.loadStatus)
    {
        if (ActivityIndicatorStyleAnnulus == self.indicatorStyle)
        {
            ActivityView *loadingView = [[ActivityView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
            loadingView.strokeColor = [self hexColor:@"#00CC99"];
            loadingView.lineWidth = 3.0f;
            loadingView.status = ActivityViewStatusLoading;
            loadingView.progress = 0;
            [loadingView startLoading];
            
            return loadingView;
        }
        else if (ActivityIndicatorStyleSystem == self.indicatorStyle)
        {
            UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
            indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
            [indicatorView startAnimating];
            
            return indicatorView;
        }
    }
    
    return nil;
}


#pragma DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
    if (LoadDataStatusFailed == self.loadStatus)
    {
        // 加载失败点击
        self.loadStatus = LoadDataStatusLoading;
        [self reloadEmptyData];
    }
}

- (UIColor *)hexColor:(NSString *)colorString
{
    unsigned int hexValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    if ([scanner scanHexInt:&hexValue])
    {
        NSInteger r = (hexValue & 0xff0000) >> 16;
        NSInteger g = (hexValue & 0x00ff00) >> 8;
        NSInteger b = hexValue & 0x0000ff;
        
        return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
    }
    
    return nil;
}



@end







