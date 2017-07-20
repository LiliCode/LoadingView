//
//  LinRefreshFooter.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/20.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "LinRefreshFooter.h"
#import "RespireAnimationView.h"



#define Width (100.0f)
#define Height (20.0f)

@interface LinRefreshFooter ()
@property (strong , nonatomic) RespireAnimationView *animationView;

@end

@implementation LinRefreshFooter


- (void)prepare
{
    [super prepare];
    
    self.mj_h = MJRefreshFooterHeight + 26;
    
    self.animationView = [[RespireAnimationView alloc] init];
    //设置属性
    self.animationView.color = MJRefreshColor(0, 193.0f, 156.0f);
    self.animationView.radius = 5;
    self.animationView.duration = .6;
    self.animationView.pointCount = 6;
    self.animationView.spacing = Width / self.animationView.pointCount;
    [self.animationView addAnimation];   //添加动画
    
    [self addSubview:self.animationView];
}

- (void)placeSubviews
{
    [super placeSubviews];
    // 布局子控件
    
    self.animationView.bounds = CGRectMake(0, 0, Width, Height);
    self.animationView.center = CGPointMake(self.mj_w / 2.0f, self.mj_h / 2.0f);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    //刷新状态
    switch (state)
    {
        case MJRefreshStateIdle:
            //普通闲置状态
            [self.animationView endAnimation];
            break;
        case MJRefreshStatePulling:
            //松开就可以进行刷新的状态
            
            break;
        case MJRefreshStateRefreshing:
            //正在刷新中
            [self.animationView startAnimation];
            break;
        case MJRefreshStateWillRefresh:
            //即将刷新的状态
            
            break;
        case MJRefreshStateNoMoreData:
            //所有数据加载完毕
            break;
            
        default: break;
    }
}


- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
}




- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
}





@end
