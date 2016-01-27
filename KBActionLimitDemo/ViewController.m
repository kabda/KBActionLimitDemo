//
//  ViewController.m
//  KBActionLimitDemo
//
//  Created by 樊远东 on 1/27/16.
//  Copyright © 2016 樊远东. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+kb_limit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [UIControl setGlobalLimitTime:2.0];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20.0, 100.0, 80.0, 44.0)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"按钮测试" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)buttonAction {
    NSLog(@"buttonAction");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
