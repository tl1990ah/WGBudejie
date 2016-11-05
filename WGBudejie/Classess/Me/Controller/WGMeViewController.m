//
//  WGMeViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/18.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGMeViewController.h"
#import "WGSettingViewController.h"

@interface WGMeViewController ()

@end

@implementation WGMeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setupNavBar];
}

- (void)setupNavBar
{
    self.view.backgroundColor = WGRandomColor;
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *setBarButtonItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highImage:@"mine-setting-icon-click"
                                                    target:self action:@selector(settingBtnClick)];
    UIBarButtonItem *moonButtonItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highImage:@"mine-moon-icon-click"
                                                                target:self action:@selector(moonBtnClick)];
    self.navigationItem.rightBarButtonItems = @[setBarButtonItem, moonButtonItem];
}

- (void)settingBtnClick
{
    WGSettingViewController *settingVC = [[WGSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)moonBtnClick
{
    WGLogFunc
}

@end
