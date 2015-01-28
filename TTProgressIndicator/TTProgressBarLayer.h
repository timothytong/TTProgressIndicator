//
//  TTProgressBarLayer.h
//  TTActivityIndicator
//
//  Created by Timothy Tong on 2015-01-23.
//  Copyright (c) 2015 Timothy Tong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface TTProgressBarLayer : CALayer

@property (nonatomic) CGFloat endAngle;
@property (nonatomic) CGFloat currentAngle;
@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGColorRef strokeColor;
@property (nonatomic) CGFloat strokeWidth;
@property (nonatomic) CFTimeInterval dur;
@property (nonatomic, readwrite) BOOL particlesEffect;
@end
