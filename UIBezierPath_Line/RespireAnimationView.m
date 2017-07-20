//
//  RespireAnimationView.m
//  UIBezierPath_Line
//
//  Created by LiliEhuu on 17/7/20.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "RespireAnimationView.h"



static NSString *const kPointLayerAnimationKey = @"pointLayerAnimation";

@interface RespireAnimationView ()
@property (strong , nonatomic) CAReplicatorLayer *replicatorLayer;
@property (strong , nonatomic) CALayer *pointLayer;

@end

@implementation RespireAnimationView

- (instancetype)init
{
    if (self = [super init])
    {
        [self initAttributes];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self initAttributes];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    self.replicatorLayer.frame = CGRectMake(0, 0, size.width/(CGFloat)_pointCount, size.height);
    self.pointLayer.bounds = CGRectMake(0, 0, _radius*2, _radius*2);
    self.pointLayer.position = CGPointMake(self.replicatorLayer.bounds.size.width / 2.0f, self.replicatorLayer.bounds.size.height / 2.0f);
}

- (CALayer *)pointLayer
{
    if (!_pointLayer)
    {
        _pointLayer = [CALayer layer];
    }
    
    return _pointLayer;
}


/**
 初始化属性
 */
- (void)initAttributes
{
    _color = [UIColor redColor];
    _pointCount = 6;
    _radius = 5.0f;
    _spacing = 12.0f;
    _duration = .8;
}

/**
 初始化动画
 */
- (void)initAnimation
{
    //创建一个可以复制自己的子图层的图层
    self.replicatorLayer = [CAReplicatorLayer layer];
    self.replicatorLayer.instanceCount = self.pointCount;      //子图层被复制的次数
    [self.layer addSublayer:self.replicatorLayer];
    
    //设置子layer的属性
    self.pointLayer.cornerRadius = _radius;
    self.pointLayer.backgroundColor = [_color CGColor];
    self.pointLayer.transform = CATransform3DMakeScale(.3, .3, .3);
    [self.replicatorLayer addSublayer:self.pointLayer];
    
    //设置父layer的属性
//    self.replicatorLayer.instanceColor = [self.color CGColor]; //被复制图层的颜色
    self.replicatorLayer.instanceTransform = CATransform3DMakeTranslation(self.spacing, 0, 0); //被复制图层的位移
    self.replicatorLayer.instanceDelay = self.duration / self.pointCount;  //延时复制
    self.replicatorLayer.backgroundColor = [[UIColor clearColor] CGColor]; //图层背景色
}

- (void)addAnimation
{
    [self initAnimation];
}

- (void)startAnimation
{
    //为子layer添加动画
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @.3;
    animation.toValue = @1;
    animation.duration = _duration;
    //往返重复
    animation.repeatCount = CGFLOAT_MAX; //重复次数
    animation.autoreverses = YES;        //往返
    [self.pointLayer addAnimation:animation forKey:kPointLayerAnimationKey];
}

- (void)endAnimation
{
    //删除动画
    [self.pointLayer removeAnimationForKey:kPointLayerAnimationKey];
}


- (void)dealloc
{
    for (NSString *animationKey in [self.pointLayer animationKeys])
    {
        if ([animationKey isEqualToString:kPointLayerAnimationKey])
        {
            [self endAnimation];
            break;
        }
    }
    
    NSLog(@"RespireAnimationView 释放");
}



@end






