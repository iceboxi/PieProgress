//
//  PieProgressView.m
//  TestPieProgress
//
//  Created by iceboxi on 2015/6/4.
//  Copyright (c) 2015年 iceboxi. All rights reserved.
//

#import "PieProgressView.h"

@interface PieProgressView ()
@property (nonatomic, retain) CAShapeLayer *progressLayer;
@property (nonatomic, assign) CFTimeInterval animationStartTime;
@property (nonatomic, assign) CGFloat animationFromValue;
@property (nonatomic, assign) CGFloat animationToValue;
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CGFloat animationDuration;
@end

@implementation PieProgressView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _progress = 1.0;
        self.animationDuration = .3;
        
        _progressLayer = [CAShapeLayer layer];
        _progressLayer.fillColor = [UIColor blackColor].CGColor;
        _progressLayer.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:_progressLayer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawProgress];
}

- (void)drawProgress
{
    float arc = _progress;
    if (arc == 1) {
        arc = 0;
    } else if (arc == 0) {
        arc = 1;
    }
    
    CGRect bounds = self.bounds;
    float startAngle = - M_PI_2;
    float endAngle = startAngle + (2.0 * M_PI * arc);
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    double radius=CGRectGetWidth(bounds)/2;
    
    //Draw path
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:center];
    [path addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:NO];
    [path closePath];
    
    //Set the path
    [_progressLayer setPath:path.CGPath];
}

- (void)setProgress:(float)progress
{
    _progress = 1-progress;
    [self setNeedsDisplay];
}

//- (void)animation {
//    [CATransaction begin];
//    [_progressLayer addAnimation:[self showAnimation] forKey:@"Show"];
//    [CATransaction commit];
//}
//
//- (CABasicAnimation *)showAnimation
//{
//    //Show the progress layer and percentage
//    CABasicAnimation *showAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    showAnimation.fromValue = [NSNumber numberWithFloat:0.0];
//    showAnimation.toValue = [NSNumber numberWithFloat:1.0];
//    showAnimation.duration = self.animationDuration;
//    showAnimation.repeatCount = 1.0;
//    //Prevent the animation from resetting
//    showAnimation.fillMode = kCAFillModeForwards;
//    showAnimation.removedOnCompletion = NO;
//    return showAnimation;
//}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    if (animated == NO) {
        if (_displayLink) {
            //Kill running animations
            [_displayLink invalidate];
            _displayLink = nil;
        }

        [self setProgress:progress];
    } else {
        _animationStartTime = CACurrentMediaTime();
        _animationFromValue = _progress;
        _animationToValue = progress;
        if (!_displayLink) {
            //Create and setup the display link
            [self.displayLink invalidate];
            self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateProgress:)];
            [self.displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
        } /*else {
           //Reuse the current display link
           }*/
    }
}

- (void)animateProgress:(CADisplayLink *)displayLink
{
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat dt = (displayLink.timestamp - _animationStartTime) / self.animationDuration;
        if (dt >= 1.0) {
            //Order is important! Otherwise concurrency will cause errors, because setProgress: will detect an animation in progress and try to stop it by itself. Once over one, set to actual progress amount. Animation is over.
            [self.displayLink invalidate];
            self.displayLink = nil;
            [self setProgress:_animationToValue];
            return;
        }
        
        //Set progress
        [self setProgress:_animationFromValue + dt * (_animationToValue - _animationFromValue)];
    });
}

@end
