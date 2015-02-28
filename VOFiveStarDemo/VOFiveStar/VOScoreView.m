//
//  VOScoreView.m
//  VOFiveStarDemo
//
//  Created by ValoLee on 15/1/2.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import "VOScoreView.h"

@interface VOStarLayer : CALayer

@property (nonatomic, assign) CGFloat value;
@property (nonatomic, strong) UIColor *starColor;
@end

@implementation VOStarLayer

-(void)drawInContext:(CGContextRef)ctx{
    [super drawInContext:ctx];
    CGFloat degRad  = M_PI/180;
    CGRect rect     = self.bounds;
    
    CGFloat radius  = MIN(rect.size.width, rect.size.height) / 2;
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    
    CGFloat r0      = radius * sin(18 * degRad)/cos(36 * degRad);  /*计算小圆半径r0 */
    CGFloat x1[5] = {0}, y1[5] = {0}, x2[5] = {0},y2[5] = {0};
    
    for (int i = 0; i < 5; i ++) {
        x1[i] = centerX + radius * cos((90 + i * 72) * degRad);    /* 计算出大圆上的五个平均分布点的坐标*/
        y1[i] = centerY - radius * sin((90 + i * 72) * degRad);
        x2[i] = centerX + r0 * cos((54 + i * 72) * degRad);        /* 计算出小圆上的五个平均分布点的坐标*/
        y2[i] = centerY - r0 * sin((54 + i * 72) * degRad);
    }
    
    CGMutablePathRef starPath = CGPathCreateMutable();
    CGPathMoveToPoint(starPath, NULL, x1[0], y1[0]);
    
    for (int i = 1; i < 5; i ++) {
        CGPathAddLineToPoint(starPath, NULL, x2[i], y2[i]);
        CGPathAddLineToPoint(starPath, NULL, x1[i], y1[i]);
    }
    
    CGPathAddLineToPoint(starPath, NULL, x2[0], y2[0]);
    CGPathCloseSubpath(starPath);
    CGContextAddPath(ctx, starPath);
    CGContextSetFillColorWithColor(ctx, self.starColor.CGColor);
    CGContextSetStrokeColorWithColor(ctx, self.starColor.CGColor);
    CGContextStrokePath(ctx);
    
    CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1]) * self.value , y1[2]);
    CGContextAddPath(ctx, starPath);
    CGContextClip(ctx);
    CGContextFillRect(ctx, range);
    CFRelease(starPath);
}

@end

@implementation VOScoreView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.starColor = [UIColor redColor];
    self.layer.masksToBounds = YES;
}

- (void)setScore:(float)score{
    _score = MIN(MAX(0, score), 5);
    [self setNeedsDisplay];
}

- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setBounds:(CGRect)bounds{
    [super setBounds:bounds];
    [self setNeedsDisplay];
}

- (void)addStarLayerWithFrame: (CGRect)frame andValue: (CGFloat)value{
    VOStarLayer *layer = [VOStarLayer layer];
    layer.frame = frame;
    layer.starColor = self.starColor;
    layer.value = value;
    [layer setNeedsDisplay];
    [self.layer addSublayer:layer];
}

- (void)drawRect:(CGRect)rect{
    // 1. 填充背景
    [self.backgroundColor setFill];
    UIRectFill(self.bounds);
    
    self.layer.sublayers = nil;
    NSInteger num = (NSInteger)self.score;
    CGFloat value = self.score - num;
    
    CGRect layerFrame     = rect;
    layerFrame.size.width = rect.size.height;
    switch (self.alignment) {
        case VOStarAlignRight:
        {
            layerFrame.origin.x = rect.origin.x + rect.size.width - rect.size.height;
            if (value > 0) {
                [self addStarLayerWithFrame:layerFrame andValue:value];
                layerFrame.origin.x -= layerFrame.size.height + self.spacing;
            }
            for (NSInteger i = 0; i < num; i ++) {
                [self addStarLayerWithFrame:layerFrame andValue:1];
                layerFrame.origin.x -= layerFrame.size.height + self.spacing;
            }
        }
            break;
            
        default:
        {
            for (NSInteger i = 0; i < num; i ++) {
                [self addStarLayerWithFrame:layerFrame andValue:1];
                layerFrame.origin.x += layerFrame.size.height + self.spacing;
            }
            if (value > 0) {
                [self addStarLayerWithFrame:layerFrame andValue:value];
            }
        }
            break;
    }
}

@end
