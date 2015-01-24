//
//  TTIndicatorView.m
//  TTProgressIndicator
//
//  Created by Timothy Tong on 2015-01-23.
//  Copyright (c) 2015 Timothy Tong. All rights reserved.
//

#import "TTIndicatorView.h"

@interface TTIndicatorView()
@property (strong, nonatomic)CALayer *containerLayer;
@property (strong, nonatomic)UIView *centerCircle;
@property (strong, nonatomic)TTProgressBarLayer *progressBar;
@property (nonatomic) CGFloat currentProgress;
@property (nonatomic) CGColorRef centerCircleColor;
@property (strong, nonatomic) NSTimer *timer;
@end
@implementation TTIndicatorView
int _tempCurProgress = 0;
int _count = 0;
int _numChanges = 0;
int _increment = 0;

@synthesize progressLabel;
-(id)initWithFrame:(CGRect)frame strokeWidth:(CGFloat)barWidth{
    self = [super initWithFrame:frame];
    if (self) {
        self.currentProgress = 0;
        CGPoint circleCenter = CGPointMake(frame.size.width/2, frame.size.width/2);
        CGFloat halfWidth = (frame.size.width - 2 * barWidth)/2;
        CGRect frame = CGRectMake(circleCenter.x - halfWidth, circleCenter.y - halfWidth, 2*halfWidth, 2*halfWidth);
        self.centerCircle = [[UIView alloc]initWithFrame:frame];
        self.containerLayer = [CAShapeLayer layer];
        self.containerLayer.frame = self.bounds;
        self.containerLayer.backgroundColor = [UIColor clearColor].CGColor;
        
        self.progressBar = [TTProgressBarLayer layer];
        self.progressBar.frame = self.bounds;
        
        [self.containerLayer addSublayer:self.progressBar];
        
        [self.layer addSublayer:self.containerLayer];
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0,0, frame.size.width, frame.size.height)].CGPath;
        
        self.centerCircle.layer.backgroundColor = [UIColor blackColor].CGColor;
        self.centerCircle.layer.mask = mask;
        
        self.progressLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.centerCircle.frame.size.width * 0.1, self.centerCircle.frame.size.height * 0.1, self.centerCircle.frame.size.width * 0.8, self.centerCircle.frame.size.height * 0.8)];
        self.progressLabel.numberOfLines = 1;
        self.progressLabel.adjustsFontSizeToFitWidth = YES;
        self.progressLabel.font = [UIFont fontWithName:@"Avenir Next Condensed" size:80];
        self.progressLabel.minimumScaleFactor = 0.2;
        self.progressLabel.text = @"0%";
        self.progressLabel.textColor = [UIColor whiteColor];
        self.progressLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.centerCircle];
        [self.centerCircle addSubview:self.progressLabel];
        
    }
    return self;
}
-(void)changeText{
    _count++;
    if (_count == _numChanges) {
        [self.timer invalidate];
        if (self.currentProgress >= 1) {
            self.currentProgress = 1;
            self.progressLabel.text = @"100%";
        }
        else{
            self.progressLabel.text = [NSString stringWithFormat:@"%.0f%%", self.currentProgress*100];
        }
        
    }
    else{
        _tempCurProgress += _increment;
        //            NSLog(@"changeTEXT to %d", _tempCurProgress);
        self.progressLabel.text = [NSString stringWithFormat:@"%d%%", _tempCurProgress];
    }
}
-(void)resetCountProperties{
    NSLog(@"RESET COUNT");
    _count = 0;
    _numChanges = 0;
    _tempCurProgress = self.currentProgress * 100;
    _increment = 0;
}
-(void)updateProgress:(CGFloat)newProgress{
    NSLog(@"==========UPDATE==========");
    [self resetCountProperties];
    
    int diff = 100 * newProgress - 100 * self.currentProgress;
    self.currentProgress = newProgress;
    NSLog(@"===DIFF: %d",diff);
    
    if (diff != 0) {
        NSTimeInterval duration = [self calculateAnimDurationWithNewProgress:newProgress];
        if (abs(diff) <= 10) {
            _numChanges = diff;
        }
        else{
            _numChanges = 10;
        }
        NSLog(@"===numchanges: %d",_numChanges);
        _increment = diff / _numChanges;
        NSLog(@"===INC: %d",_increment);
        NSTimeInterval pause = duration/_numChanges;
        NSLog(@"===pause: %.4f",pause);
        self.timer = [NSTimer scheduledTimerWithTimeInterval:pause
                                                      target:self
                                                    selector:@selector(changeText)
                                                    userInfo:nil
                                                     repeats:YES];
    }
    
    CGFloat newEndAngle = 2 * M_PI * newProgress;
    self.progressBar.startAngle = 0;
    self.progressBar.endAngle = newEndAngle;
    //    NSLog(@"New end angle: 2 * %f * %f = %f", M_1_PI, newProgress, newEndAngle);
    
    
    
}

-(void)setBarColor:(UIColor *)color{
    [self.progressBar setBarColor:color.CGColor];
}
-(void)setCenterColor:(UIColor *)color withAnimationTime:(double)time{
    NSLog(@"setting center color");
    [UIView animateWithDuration:time delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.centerCircle.layer.backgroundColor = color.CGColor;
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [self bringSubviewToFront:self.centerCircle];
}

-(void)setShowProgressValues:(BOOL)showProgressValues{
    if (showProgressValues) {
        self.centerCircle.alpha = 1;
    }
    else{
        self.centerCircle.alpha = 0;
    }
}

- (double)calculateAnimDurationWithNewProgress:(CGFloat)progress{
    CGFloat startAngle = self.progressBar.endAngle;
    CGFloat endAngle = progress * 2 * M_PI;
    double interval = abs((startAngle - endAngle) * 5.0f);
    NSLog(@"Start: %f, End: %f, interval: %f", startAngle,endAngle,interval);
    if (interval > 1.3) {
        interval = 1.3;
    }
    NSLog(@"Calculated duration: %f", interval);
    return interval;
}


@end
