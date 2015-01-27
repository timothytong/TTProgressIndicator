//
//  TTIndicatorView.m
//  TTProgressIndicator
//
//  Created by Timothy Tong on 2015-01-23.
//  Copyright (c) 2015 Timothy Tong. All rights reserved.
//

#import "TTIndicatorView.h"

@interface TTIndicatorView()
@end
@implementation TTIndicatorView{
    @private
    TTProgressBarLayer *_progressBar;
    CGColorRef _centerCircleColor; //not used yet
    CGFloat _currentProgress;
    NSTimer *_timer;
    UIView *_centerCircle;
    CALayer *_containerLayer;
    int _tempCurProgress;
    int _count;
    int _numChanges;
    int _increment;
}
-(id)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)barWidth{
    self = [super initWithFrame:frame];
    if (self) {
        _currentProgress = 0;
        CGPoint circleCenter = CGPointMake(frame.size.width/2, frame.size.width/2);
        CGFloat halfWidth = (frame.size.width - 2 * barWidth)/2;
        CGRect frame = CGRectMake(circleCenter.x - halfWidth, circleCenter.y - halfWidth, 2*halfWidth, 2*halfWidth);
        _centerCircle = [[UIView alloc]initWithFrame:frame];
        _containerLayer = [CAShapeLayer layer];
        _containerLayer.frame = self.bounds;
        _containerLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        _progressBar = [TTProgressBarLayer layer];
        _progressBar.frame = self.bounds;
        
        [_containerLayer addSublayer:_progressBar];
        
        [self.layer addSublayer:_containerLayer];
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, frame.size.width, frame.size.height)].CGPath;
        
        _centerCircle.layer.backgroundColor = [UIColor blackColor].CGColor;
        _centerCircle.layer.mask = mask;
        
        self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(_centerCircle.frame.size.width * 0.1, _centerCircle.frame.size.height * 0.1, _centerCircle.frame.size.width * 0.8, _centerCircle.frame.size.height * 0.8)];
        self.progressLabel.numberOfLines = 1;
        self.progressLabel.adjustsFontSizeToFitWidth = YES;
        self.progressLabel.font = [UIFont fontWithName:@"Avenir Next Condensed" size:80];
        self.progressLabel.minimumScaleFactor = 0.2;
        self.progressLabel.text = @"0%";
        self.progressLabel.textColor = [UIColor whiteColor];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_centerCircle];
        [_centerCircle addSubview:self.progressLabel];
        
    }
    return self;
}
-(void)changeText{
    _count++;
    NSLog(@"    ===COUNT: %d",_count);
    if (_count == _numChanges) {
        NSLog(@"Invalidating _timer");
        [_timer invalidate];
        if (_currentProgress >= 1) {
            _currentProgress = 1;
            self.progressLabel.text = @"100%";
        }
        else{
            self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", _currentProgress*100];
        }
        
    }
    else{
        _tempCurProgress += _increment;
        if (_tempCurProgress <= 0 || _tempCurProgress >= 100) {
            [_timer invalidate];
        }
        else{
            self.progressLabel.text = [NSString stringWithFormat:@"%d%%", _tempCurProgress];    
        }
        
    }
}
-(void)resetCountProperties{
    NSLog(@"RESET COUNT");
    _count = 0;
    _numChanges = 0;
    _tempCurProgress = _currentProgress * 100;
    _increment = 0;
}
-(void)updateProgress:(CGFloat)newProgress animationDuration:(CFTimeInterval)duration{
    [_timer invalidate];
    _progressBar.dur = duration;
    if (newProgress > 1) {
        newProgress = 1;
    }
    NSLog(@"==========UPDATE: FROM %.0f to %.0f==========",_currentProgress*100, newProgress*100);
    [self resetCountProperties];
    
    int diff = 100 * newProgress - 100 * _currentProgress;
    _currentProgress = newProgress;
    NSLog(@"===DIFF: %d",diff);
    
    if (diff != 0) {
        if (abs(diff) <= 20) {
            _numChanges = diff;
        }
        else{
            _numChanges = 20;
        }
        NSLog(@"===numchanges: %d",_numChanges);
        _increment = diff / _numChanges;
        NSLog(@"===INC: %d",_increment);
        double pause = duration/_numChanges;
        NSLog(@"===pause: %.4f",pause);
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:pause
                                                      target:self
                                                    selector:@selector(changeText)
                                                    userInfo:nil
                                                     repeats:YES];
         
    }
    
    CGFloat newEndAngle = 2 * M_PI * newProgress - M_PI_2;
//    _progressBar.startAngle = -M_PI_2;
    _progressBar.endAngle = newEndAngle;
    //    NSLog(@"New end angle: 2 * %f * %f = %f", M_1_PI, newProgress, newEndAngle);
    
    
    
}

-(void)setBarColor:(UIColor *)color{
    [_progressBar setBarColor:color.CGColor];
}
-(void)setCenterColor:(UIColor *)color withAnimationTime:(double)time{
    NSLog(@"setting center color");
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _centerCircle.layer.backgroundColor = color.CGColor;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [self bringSubviewToFront:_centerCircle];
}

-(void)setShowProgressValues:(BOOL)showProgressValues{
    if (showProgressValues) {
        _centerCircle.alpha = 1;
    }
    else{
        _centerCircle.alpha = 0;
    }
}
/*
- (NSTimeInterval)calculateAnimDurationWithNewProgress:(CGFloat)progress{
    CGFloat startAngle = _progressBar.endAngle;
    CGFloat endAngle = progress * 2 * M_PI - M_PI_2;
    NSTimeInterval interval = (startAngle - endAngle) * 3.0f;
    if (interval < 0) {
        interval = -interval;
    }
    NSLog(@"Start: %f, End: %f, interval: %f", startAngle, endAngle, interval);
    if (interval > 0.5) {
        interval = 0.5;
    }
    NSLog(@"Calculated duration: %f", interval);
    return 0.8;
    
}
*/

-(void)reset{
    _currentProgress = 0;
    _progressBar.endAngle = -M_PI_2;
    _progressBar.startAngle = -M_PI_2;
    self.progressLabel.text = @"0%";
}

@end
