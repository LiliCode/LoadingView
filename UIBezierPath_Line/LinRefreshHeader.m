//
//  LinRefreshHeader.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/19.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "LinRefreshHeader.h"
#import "ActivityView.h"


@interface LinRefreshHeader ()
@property (strong , nonatomic) ActivityView *loadingView;

@end

@implementation LinRefreshHeader

- (void)prepare
{
    [super prepare];
    self.mj_h = MJRefreshHeaderHeight + 24;
    // 添加子控件
    self.loadingView = [[ActivityView alloc] init];
    self.loadingView.lineWidth = 2.0f;
    self.loadingView.strokeColor = MJRefreshColor(0, 193.0f, 156.0f);
    self.loadingView.progress = 0;
    [self.loadingView startLoading];
    [self addSubview:self.loadingView];
}

- (void)placeSubviews
{
    [super placeSubviews];
    // 布局子控件
    CGRect frame;
    CGSize size = CGSizeMake(30, 30);
    CGPoint origin = CGPointMake(self.mj_w / 2.0f - size.width/2.0f, self.mj_h / 2.0f - size.height/2.0f);
    frame.origin = origin;
    frame.size = size;
    self.loadingView.frame = frame;
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    //刷新状态
    switch (state)
    {
        case MJRefreshStateIdle:
            //普通闲置状态
            break;
        case MJRefreshStatePulling:
            //松开就可以进行刷新的状态
            
            break;
        case MJRefreshStateRefreshing:
            //正在刷新中
            self.loadingView.status = ActivityViewStatusLoading;
            break;
        case MJRefreshStateWillRefresh:
            //即将刷新的状态
            self.loadingView.status = ActivityViewStatusWillLoad;
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
    //拖拽进度
    if (self.state == MJRefreshStateIdle)
    {
        self.loadingView.progress = pullingPercent;
        
        if (!(bool)pullingPercent)
        {
            self.loadingView.status = ActivityViewStatusWillLoad;
        }
    }
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






