//
//  ViewController.m
//  TTProgressIndicator
//
//  Created by Timothy Tong on 2015-01-23.
//  Copyright (c) 2015 Timothy Tong. All rights reserved.
//

#import "ViewController.h"
#import "TTIndicatorView.h"
@interface ViewController ()
@property (strong, nonatomic)TTIndicatorView *indicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.indicator = [[TTIndicatorView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2 - 120, self.view.frame.size.height/2 - 120, 240, 240) strokeWidth:5];
    [self.view addSubview:self.indicator];
            [self.indicator reset];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    /* Simultaneous calls
    [self.indicator updateProgress:0.1];
    [self.indicator updateProgress:0.2];
    [self.indicator updateProgress:0.3];
    [self.indicator updateProgress:0.5];
    [self.indicator updateProgress:0.9];
     */
/*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:2.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.indicator updateProgress:0.01];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [NSThread sleepForTimeInterval:2.0f];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
            [self.indicator updateProgress:0.04];
//                    self.indicator.progressLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:100]
                });
            });
        });
    });
    */

    [self delayWithSeconds:2 handler:^{
        [self.indicator updateProgress:0.2 animationDuration:4];
    }];

/*
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:4.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicator setBarColor:[UIColor greenColor]];
            [self.indicator setCenterColor:[UIColor blueColor] withAnimationTime:0.4];
        });
    });
     */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)delayWithSeconds:(int64_t)seconds handler:(void(^)(void))handler{
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        handler();
    });
}

@end
