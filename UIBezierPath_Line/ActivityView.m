//
//  ActivityView.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/18.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "ActivityView.h"

@interface ActivityView ()
{
    CGFloat _startAngle;    //圆形起点弧度
    CGFloat _endAngle;      //圆形终点弧度
    CGFloat _lineWidth;     //线宽
    CGFloat _reduis;        //半径
}

@property (strong , nonatomic) CAShapeLayer *animationLayer;    //展示动画的图层
@property (strong , nonatomic) CADisplayLink *link;             //执行动画的对象

@end

@implementation ActivityView

- (instancetype)init
{
    if (self = [super init])
    {
        [self initAnimation];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initAnimation];
    }
    
    return self;
}

- (void)initAnimation
{
    _startAngle = -M_PI_2;
    _endAngle = _startAngle;
    _lineWidth = 5.0f;
    _reduis = self.bounds.size.width / 2.0f - _lineWidth;
    
    self.animationLayer.bounds = self.bounds;
    [self setStrokeColor:[UIColor redColor]];
    [self setFillColor:[UIColor clearColor]];
    self.animationLayer.lineWidth = _lineWidth;
    [self.layer addSublayer:self.animationLayer];
    [self endLoading];
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (CAShapeLayer *)animationLayer
{
    if (!_animationLayer)
    {
        _animationLayer = [CAShapeLayer layer];
        _animationLayer.lineCap = kCALineCapRound;
        _animationLayer.lineJoin = kCALineJoinRound;
    }
    
    return _animationLayer;
}

- (CADisplayLink *)link
{
    if (!_link)
    {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(drawAnimationLayer)];
    }
    
    return _link;
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    
    self.animationLayer.strokeColor = [strokeColor CGColor];
}

- (void)setFillColor:(UIColor *)fillColor
{
    _fillColor = fillColor;
    
    self.animationLayer.fillColor = [fillColor CGColor];
}


- (void)drawAnimationLayer
{
    switch (self.status)
    {
        case ActivityViewStatusWillLoad:
            [self drawWillLoadAnimation];
            break;
        case ActivityViewStatusLoading:
            [self drawLoadingAnimation];
            break;
        case ActivityViewStatusCompleted:
            [self drawCompletedAnimation];
            break;
            
        default: break;
    }
}

- (void)drawWillLoadAnimation
{
    CGFloat endAngle = _progress * 2 * M_PI - M_PI_2;
    self.animationLayer.path = [[UIBezierPath bezierPathWithArcCenter:self.center radius:_reduis startAngle:_startAngle endAngle:endAngle clockwise:YES] CGPath];
}

- (void)drawLoadingAnimation
{
    self.progress += [self speed];
    if (_progress >= 1)
    {
        _progress = 0;
    }
    
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 + _progress * M_PI * 2;
    if (_endAngle > M_PI)
    {
        _startAngle = -M_PI_2 + 4 * _progress * M_PI * 2;
    }
    
    self.animationLayer.path = [[UIBezierPath bezierPathWithArcCenter:self.center radius:_reduis startAngle:_startAngle endAngle:_endAngle clockwise:YES] CGPath];
}

- (void)drawCompletedAnimation
{
    _progress += [self speed];
    if (_progress >= 1)
    {
        _progress = 0;
    }
    
    _startAngle = -M_PI_2;
    _endAngle = -M_PI_2 + _progress * M_PI * 2;
    self.animationLayer.path = [[UIBezierPath bezierPathWithArcCenter:self.center radius:_reduis startAngle:_startAngle endAngle:_endAngle clockwise:YES] CGPath];
}


- (CGFloat)speed
{
    if (_endAngle > M_PI && self.status != ActivityViewStatusCompleted)
    {
        return 0.3/60.0f;   //如果status == ActivityViewStatusCompleted 不使用此速度
    }
    
    return 2/60.0f;
}

- (void)startLoading
{
    self.link.paused = NO;
}

- (void)endLoading
{
    self.link.paused = YES;
}

- (void)remove
{
    [self.link invalidate];
}



- (void)dealloc
{
    NSLog(@"ActivityView 释放");
}

@end



