//
//  ViewController.m
//  TestPieProgress
//
//  Created by iceboxi on 2015/6/4.
//  Copyright (c) 2015年 iceboxi. All rights reserved.
//

#import "ViewController.h"
#import "PieProgressView.h"

#define MAX_WAIT_SEC 5.0

@interface ViewController () {
    float sec;
}
@property (weak, nonatomic) IBOutlet PieProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toChange:(UISlider *)sender {
    [self.progressView setProgress:sender.value];
}

- (IBAction)animationPieProgress:(id)sender {
    sec = MAX_WAIT_SEC;
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(progress:) userInfo:nil repeats:YES];
}

- (void)progress:(NSTimer *)timer {
    sec -= timer.timeInterval;
    [self.progressView setProgress:(MAX_WAIT_SEC-sec)/MAX_WAIT_SEC];
    
    if (sec - timer.timeInterval <= 0)
    {
        [timer invalidate];
    }
}
@end
