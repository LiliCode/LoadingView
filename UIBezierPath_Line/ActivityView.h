//
//  ActivityView.h
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/18.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 ActivityView的状态

 - ActivityViewStatusWillLoad: 将要加载
 - ActivityViewStatusLoading: 正在加载
 - ActivityViewStatusCompleted: 加载完成
 */
typedef NS_ENUM(NSUInteger , ActivityViewStatus)
{
    ActivityViewStatusWillLoad,
    ActivityViewStatusLoading,
    ActivityViewStatusCompleted
};

@interface ActivityView : UIView

@property (strong , nonatomic) UIColor *strokeColor;        //线条颜色
@property (strong , nonatomic) UIColor *fillColor;          //填充颜色
@property (assign , nonatomic) CGFloat progress;            //进度值
@property (assign , nonatomic) ActivityViewStatus status;   //状态



/**
 启动
 */
- (void)startLoading;

/**
 停止
 */
- (void)endLoading;

/**
 移除
 */
- (void)remove;

@end




