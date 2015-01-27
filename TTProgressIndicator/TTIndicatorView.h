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
@property(strong, nonatomic)UILabel *progressLabel;


- (void)updateProgress:(CGFloat)newProgress animationDuration:(CFTimeInterval)duration;
-(id)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)barWidth;
-(void)setBarColor:(UIColor *)color;
-(void)setCenterColor:(UIColor *)color withAnimationTime:(double)time;
-(void)reset;
@end
