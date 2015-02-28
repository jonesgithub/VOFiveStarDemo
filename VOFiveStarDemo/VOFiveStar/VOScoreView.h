//
//  VOScoreView.h
//  VOFiveStarDemo
//
//  Created by ValoLee on 15/1/2.
//  Copyright (c) 2015年 ValoLee. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, VOStarAlign) {
    VOStarAlignLeft,
    VOStarAlignRight,
};

@interface VOScoreView : UIView

@property (nonatomic, assign) float       score;
@property (nonatomic, assign) float       spacing;
@property (nonatomic, strong) UIColor     *starColor;
@property (nonatomic, assign) VOStarAlign alignment;

@end
