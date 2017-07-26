//
//  MBProgressHUD+Loading.h
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/26.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (Loading)

/**
 显示文本信息

 @param text 文本信息
 @param view 添加到那个view
 @param delay 延时几秒消失
 @return 返回HUD
 */
+ (instancetype)showText:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay;

/**
 显示加载动画

 @param view 添加到那个view
 @return 返回HUD
 */
+ (instancetype)showLoadingAddedTo:(UIView *)view;




@end



