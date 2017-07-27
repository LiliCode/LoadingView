//
//  UIViewController+Loading.h
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/27.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 页面加载数据的状态

 - LoadDataStatusLoading: 加载中
 - LoadDataStatusFailed: 加载失败
 - LoadDataStatusSuccessed: 加载成功
 */
typedef NS_ENUM(NSUInteger, LoadDataStatus)
{
    LoadDataStatusLoading,
    LoadDataStatusFailed,
    LoadDataStatusSuccessed
};


/**
 活动指示器的风格

 - LoadingIndicatorStyleSystem: 系统默认的UIActivityIndicatorView
 - LoadingIndicatorStyleAnnulus: 圆环形状的活动指示器
 - LoadingIndicatorStyleCustom: 自定义风格的活动指示器
 */
typedef NS_ENUM(NSUInteger, LoadingIndicatorStyle)
{
    LoadingIndicatorStyleSystem,
    LoadingIndicatorStyleAnnulus,
    LoadingIndicatorStyleCustom
};


typedef void (^LoadingCallbackBlock)(UILabel *label, LoadDataStatus status);

@interface UIViewController (Loading)

@property (strong , nonatomic) UIColor *loading_textColor;  //提示文字的颜色
@property (assign , nonatomic) LoadDataStatus loading_loadStatus;    //加载的状态
@property (assign , nonatomic) LoadingIndicatorStyle loading_indicatorStyle;    //指示器的风格


- (void)showStatusText:(NSString *)text loadingStyle:(LoadingIndicatorStyle)loadingStyle click:(LoadingCallbackBlock)clickBlock;

- (void)hideLoading;

- (void)placeSubviews;

@end







