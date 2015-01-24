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
    [self.indicator updateProgress:0];
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSThread sleepForTimeInterval:2.0f];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.indicator updateProgress:0.4];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [NSThread sleepForTimeInterval:2.0f];
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.indicator updateProgress:0.5];
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                        
                        [NSThread sleepForTimeInterval:2.0f];
                        dispatch_async(dispatch_get_main_queue(), ^{

                            [self.indicator updateProgress:0.75];
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                
                                [NSThread sleepForTimeInterval:2.0f];
                                dispatch_async(dispatch_get_main_queue(), ^{
        
                                    [self.indicator updateProgress:0.96];
                                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                        
                                        [NSThread sleepForTimeInterval:2.0f];
                                        dispatch_async(dispatch_get_main_queue(), ^{
                
                                            [self.indicator updateProgress:1];
                                            [NSThread sleepForTimeInterval:2.0f];
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                
                                                [self.indicator updateProgress:0.34];
                                                [NSThread sleepForTimeInterval:2.0f];
                                                dispatch_async(dispatch_get_main_queue(), ^{
                                                    
                                                    [self.indicator updateProgress:1];
                                                    [NSThread sleepForTimeInterval:2.0f];
                                                    dispatch_async(dispatch_get_main_queue(), ^{
                                                        
                                                        [self.indicator updateProgress:0];
                                                    });
                                                });
                                            });
                                        });
                                    });
                                });
                            });
                        });
                    });
                });
            });
        });
    });
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

@end
