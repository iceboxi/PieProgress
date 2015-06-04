//
//  ViewController.m
//  TestPieProgress
//
//  Created by iceboxi on 2015/6/4.
//  Copyright (c) 2015年 iceboxi. All rights reserved.
//

#import "ViewController.h"
#import "CycleView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet CycleView *progressView;

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

@end
