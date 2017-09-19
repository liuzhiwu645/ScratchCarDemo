//
//  ViewController.m
//  LzwScratchCarDemo
//
//  Created by pc37 on 2017/9/18.
//  Copyright © 2017年 AME. All rights reserved.
//

#import "ViewController.h"
#import "LzwScratchCarView.h"

@interface ViewController ()

@property (nonatomic, strong) LzwScratchCarView *scratchCardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.scratchCardView = [[LzwScratchCarView alloc]initWithFrame:CGRectMake(100, 100, 150, 150)];
    _scratchCardView.image = [UIImage imageNamed:@"1.png"];
    [self.view addSubview:_scratchCardView];
    _scratchCardView.completion = ^(NSDictionary *dictInfo)
    {
        NSLog(@"中奖了!!!");
    };
    
    UIButton *btnReset = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReset.frame = CGRectMake(100, 400, 100, 30);
    [btnReset setTitle:@"再来一次" forState:UIControlStateNormal];
    [btnReset setTitleColor:[UIColor cyanColor] forState:UIControlStateNormal];
    btnReset.backgroundColor = [UIColor redColor];
    [self.view addSubview:btnReset];
    
    [btnReset addTarget:self action:@selector(resetThisscratchCardView:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)resetThisscratchCardView:(UIButton *)button
{
    [_scratchCardView resetScratchCompletionCar];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
