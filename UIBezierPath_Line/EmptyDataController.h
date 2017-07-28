//
//  EmptyDataController.h
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/28.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 页面加载数据的状态
 
 - LoadDataStatusLoading: 加载中
 - LoadDataStatusEmptyData: 空数据
 - LoadDataStatusFailed: 加载失败或者网络错误
 - LoadDataStatusSuccessed: 加载成功
 */
typedef NS_ENUM(NSUInteger, LoadDataStatus)
{
    LoadDataStatusLoading,
    LoadDataStatusEmptyData,
    LoadDataStatusFailed,
    LoadDataStatusSuccessed
};


/**
 活动指示器的风格
 
 - ActivityIndicatorStyleSystem: 系统默认的UIActivityIndicatorView
 - ActivityIndicatorStyleAnnulus: 圆环形状的活动指示器
 - ActivityIndicatorStyleCustom: 自定义风格的活动指示器
 */
typedef NS_ENUM(NSUInteger, ActivityIndicatorStyle)
{
    ActivityIndicatorStyleSystem,
    ActivityIndicatorStyleAnnulus,
    ActivityIndicatorStyleCustom
};


@interface EmptyDataController : NSObject
/** 空数据图片 */
@property (strong , nonatomic) UIImage *emptyDataImage;
/** 空数据提示文字 */
@property (copy , nonatomic) NSAttributedString *titleText;
/** 空数据详细提示文字 */
@property (copy , nonatomic) NSAttributedString *detailText;
/** 按钮标题 */
@property (copy , nonatomic) NSAttributedString *buttonTitle;
/** 按钮背景颜色-图片 */
@property (strong , nonatomic) UIImage *buttonBackgroundImage;
/** 设置页面的背景色 */
@property (strong , nonatomic) UIColor *backgroundColor;
/** 垂直方向偏移 默认:-64.0f*/
@property (assign , nonatomic) CGFloat verticalOffset;
/** 网络错误的图片 */
@property (strong , nonatomic) UIImage *networkErrorImage;
/** 页面数据加载的状态 */
@property (assign , nonatomic) LoadDataStatus loadStatus;
/** 活动指示器的类型 */
@property (assign , nonatomic) ActivityIndicatorStyle indicatorStyle;



/**
 构造方法

 @param scollView 需要显示空数据的UIScrollView的子类对象
 @return 返回一个EmptyDataController 实例
 */
+ (instancetype)emptyData:(__weak UIScrollView *)scollView;

/**
 刷新空数据
 */
- (void)reloadEmptyData;

@end



