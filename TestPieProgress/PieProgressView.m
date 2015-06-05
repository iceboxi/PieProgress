//
//  PieProgressView.m
//  TestPieProgress
//
//  Created by iceboxi on 2015/6/4.
//  Copyright (c) 2015年 iceboxi. All rights reserved.
//

#import "PieProgressView.h"

@implementation PieProgressView

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _progress = 1.0;
        [self setBackgroundColor:[UIColor blackColor]];

        [self.layer setCornerRadius:CGRectGetWidth(self.bounds)*.5];
        [self.layer setMasksToBounds:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect parentViewBounds = self.bounds;

    // Get the graphics context and clear it
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextClearRect(ctx, rect);
    
    CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0);
    CGContextSetRGBStrokeColor(ctx, 1.0, 1.0, 1.0, 1);
    CGContextSetLineWidth(ctx, 0.1);
    
    double radius=CGRectGetWidth(parentViewBounds)/2+1;
    int startX=CGRectGetMidX(parentViewBounds);
    int startY=CGRectGetMidY(parentViewBounds);
    float startAngle = - M_PI_2;
    float endAngle = startAngle + (2.0 * M_PI * _progress);
    int clockwise=0;
    
    CGContextMoveToPoint(ctx, startX, startY);
    CGContextAddArc(ctx, startX, startY, radius, startAngle, endAngle, clockwise);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathEOFillStroke);
}

- (void)setProgress:(float)progress
{
    _progress = 1-progress;
    [self setNeedsDisplay];
}

@end
