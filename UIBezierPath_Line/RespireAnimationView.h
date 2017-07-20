//
//  RespireAnimationView.h
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/20.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespireAnimationView : UIView

@property (strong , nonatomic) UIColor *color;          //颜色
@property (assign , nonatomic) NSUInteger pointCount;   //多少个点
@property (assign , nonatomic) CGFloat radius;          //点的半径
@property (assign , nonatomic) CGFloat spacing;         //间隔
@property (assign , nonatomic) NSTimeInterval duration; //动画时长


/**
 添加动画
 */
- (void)addAnimation;

/**
 开始动画
 */
- (void)startAnimation;

/**
 结束动画
 */
- (void)endAnimation;


@end
