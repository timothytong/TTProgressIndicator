//
//  TTIndicatorView.h
//  TTProgressIndicator
//
//  Created by Timothy Tong on 2015-01-23.
//  Copyright (c) 2015 Timothy Tong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TTProgressBarLayer.h"
@interface TTIndicatorView : UIView
@property(nonatomic, readwrite) BOOL showProgressValues;
@property(nonatomic, weak) UIColor *centerCircleColor;
@property(nonatomic, weak) UIColor *labelColor;
@property(nonatomic) NSTextAlignment alignment;
@property(nonatomic, weak) UIFont *labelFont;
@property(nonatomic, weak) UIColor *barColor;

- (void)updateProgress:(CGFloat)newProgress withAnimationDuration:(CFTimeInterval)duration;
-(id)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)barWidth;
-(void)setCenterColor:(UIColor *)color withAnimationTime:(CFTimeInterval)time;
-(void)reset;
@end
