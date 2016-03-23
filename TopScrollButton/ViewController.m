//
//  ViewController.m
//  TopScrollButton
//
//  Created by Alex on 16/3/23.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "ScrollButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arT = @[@"测试1", @"测试2", @"测试3", @"测试4", @"测试5", @"测试6", @"测试7", @"测试8", @"测试9", @"测试10"];
    ScrollButton *scrollBtn = [[ScrollButton alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
    scrollBtn.btnTitleArray = [NSMutableArray arrayWithArray:arT];
    [self.view addSubview:scrollBtn];
    
    [scrollBtn buttonClickedBlock:^(NSInteger index) {
        NSLog(@"----->%ld",index);
    }];
}

//- (void)changeColorForButton:(UIButton *)btn red:(float)nRedPercent
//{
//    float value = [QHCommonUtil lerp:nRedPercent min:0 max:212];
//    [btn setTitleColor:RGBA(value,25,38,1) forState:UIControlStateNormal];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
