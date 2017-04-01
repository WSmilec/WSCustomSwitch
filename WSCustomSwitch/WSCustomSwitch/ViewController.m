//
//  ViewController.m
//  WSCustomSwitch
//
//  Created by WangS on 2017/4/1.
//  Copyright © 2017年 WangS. All rights reserved.
//

#import "ViewController.h"
#import "WSCustomSwitch.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    WSCustomSwitch *sw = [[WSCustomSwitch alloc] initWithFrame:CGRectMake(100, 100, 86, 24) onColor:UIColorFromRGB(0xffc000) offColor:UIColorFromRGB(0xeb0000) onText:@"关闭技能" offText:@"点亮技能" textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14] ballSize:24];
    sw.on = YES;
    [self.view addSubview:sw];}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
