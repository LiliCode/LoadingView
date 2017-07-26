//
//  MBProgressHUD+Loading.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/26.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "MBProgressHUD+Loading.h"
#import "ActivityView.h"



@implementation MBProgressHUD (Loading)

+ (instancetype)showText:(NSString *)text toView:(UIView *)view afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.userInteractionEnabled = NO;
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    CGPoint offset = hud.offset;
    offset.y = ([UIScreen mainScreen].bounds.size.height/2.0f)*(0.53973013);
    hud.offset = offset;
    [hud hideAnimated:YES afterDelay:delay];
    
    return hud;
}

+ (instancetype)showLoadingAddedTo:(UIView *)view
{
    MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.userInteractionEnabled = NO;
    ActivityView *activity = [[ActivityView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    activity.progress = 0;
    activity.lineWidth = 3;
    activity.strokeColor = [UIColor colorWithRed:0 green:193.0/255.0f blue:156.0f/255.0f alpha:1];
    activity.status = ActivityViewStatusLoading;
    [activity startLoading];
    hud.customView = activity;
    
    return hud;
}


@end




