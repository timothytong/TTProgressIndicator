//
//  TTSpinnerLayer.m
//  TTActivityIndicator
//
//  Created by Timothy Tong on 2015-01-23.
//  Copyright (c) 2015 Timothy Tong. All rights reserved.
//

#import "TTProgressBarLayer.h"
@interface TTProgressBarLayer()

@end
@implementation TTProgressBarLayer

@dynamic startAngle,endAngle;

-(id)init{
    self = [super init];
    if (self) {
        self.strokeColor = [UIColor redColor].CGColor;
        self.strokeWidth = 1.0;
        self.startAngle = -M_PI_2;
        self.endAngle = -M_PI_2;
        self.dur = 0.8;
        [self setNeedsDisplay];
    }
    return self;
}
-(void)setBarColor:(CGColorRef)color{
    self.strokeColor = color;
    [self setNeedsDisplay];
}
- (id)initWithLayer:(id)layer {
    if (self = [super initWithLayer:layer]) {
        if ([layer isKindOfClass:[TTProgressBarLayer class]]) {
            TTProgressBarLayer *originalLayer = (TTProgressBarLayer *)layer;
            self.startAngle = originalLayer.startAngle;
            self.endAngle = originalLayer.endAngle;
            self.strokeColor = originalLayer.strokeColor;
            self.strokeWidth = originalLayer.strokeWidth;
        }
    }
    
    return self;
}

+(BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"startAngle"]||[key isEqualToString:@"endAngle"]) {
                NSLog(@"Returning YES for %@", key);
        return YES;
    }
    return [super needsDisplayForKey:key];
}

-(void)drawInContext:(CGContextRef)ctx{
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    CGFloat radius = self.bounds.size.width / 2;
    CGContextBeginPath(ctx);
    	CGContextMoveToPoint(ctx, center.x, center.y);
    CGPoint intermediate = CGPointMake(center.x + cosf(self.startAngle), center.y + sinf(self.startAngle));
    
//    NSLog(@"Center: (%f, %f), Intermediate point (%f,%f)",center.x, center.y, intermediate.x,intermediate.y);
    CGContextAddLineToPoint(ctx, intermediate.x, intermediate.y);
    CGContextAddArc(ctx, center.x, center.y, radius, self.startAngle, self.endAngle, (self.startAngle > self.endAngle));
    CGContextClosePath(ctx);
    CGContextSetFillColorWithColor(ctx, self.strokeColor);
    CGContextSetStrokeColorWithColor(ctx, [UIColor clearColor].CGColor);
    CGContextSetLineWidth(ctx, self.strokeWidth);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

-(id<CAAction>)actionForKey:(NSString *)key{
    if ([key isEqualToString:@"startAngle"]||[key isEqualToString:@"endAngle"]) {
        NSLog(@"Returning CAAction for %@", key);
        return [self generateAnimationForKey:key];
    }
    return [super actionForKey:key];
}

-(CABasicAnimation *)generateAnimationForKey:(NSString *)key{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
    animation.fromValue = [[self presentationLayer] valueForKey:key];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = self.dur;
    NSLog(@"FROM LAYER: Duration: %f",animation.duration);
    return animation;
}
@end
