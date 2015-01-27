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
    self.view.backgroundColor = [UIColor colorWithRed:140.0/255.0 green:140.0/255.0 blue:140.0/255.0 alpha:1];
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
    
    [self delayWithSeconds:2 handler:^{
        [self.indicator updateProgress:1 withAnimationDuration:4];
    }];
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
