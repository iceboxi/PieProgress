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
    
    float startAngle = - M_PI_2;
    float endAngle1 = startAngle + (2.0 * M_PI * 1);
    float endAngle0 = startAngle + (2.0 * M_PI * 0);
    
    NSLog(@"%f, %f, %f", startAngle, endAngle0, endAngle1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)toChange:(UISlider *)sender {
    [self.progressView setProgress:sender.value];
}

- (IBAction)animationPieProgress:(id)sender {
    [_progressView setProgress:1 animated:YES];
}

@end
