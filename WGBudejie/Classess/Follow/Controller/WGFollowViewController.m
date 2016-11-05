//
//  WGFollowViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/18.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGFollowViewController.h"
#import "WGLoginRegisterViewController.h"

@interface WGFollowViewController ()

@end

@implementation WGFollowViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self setupSubView];
}

- (void)setupNavBar
{
    self.view.backgroundColor = WGCommonBgColor;
    self.navigationItem.title = @"我的关注";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highImage:@"friendsRecommentIcon-click" target:self action:@selector(btnClick)];
}

- (void)setupSubView
{
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header_cry_icon"]];
    icon.frame = CGRectMake((WIDTH - 48) * 0.5, 180, 48, 48);
    [self.view addSubview:icon];
    
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.frame = CGRectMake((WIDTH - 200) * 0.5, CGRectGetMaxY(icon.frame) + 60, 200, 60);
    messageLabel.numberOfLines = 0;
    messageLabel.font = [UIFont systemFontOfSize:15];
    messageLabel.text = @"快快登录吧，关注百思最in牛人  好友动态让你过把瘾～         欧耶～～～";
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:messageLabel];
    
    UIButton *loginOrRegisterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginOrRegisterBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login"] forState:UIControlStateNormal];
    [loginOrRegisterBtn setBackgroundImage:[UIImage imageNamed:@"friendsTrend_login_click"] forState:UIControlStateHighlighted];
    [loginOrRegisterBtn setTitle:@"立即登录注册" forState:UIControlStateNormal];
    loginOrRegisterBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [loginOrRegisterBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [loginOrRegisterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    loginOrRegisterBtn.frame = CGRectMake((WIDTH - 243) * 0.5, CGRectGetMaxY(messageLabel.frame)+ 30, 243, 35);
    [loginOrRegisterBtn addTarget:self action:@selector(loginAndRegister) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginOrRegisterBtn];
}

- (void)loginAndRegister
{
    WGLoginRegisterViewController *loginRegisterVC = [[WGLoginRegisterViewController alloc] init];
    [self presentViewController:loginRegisterVC animated:YES completion:nil];
}

- (void)btnClick
{
    WGLogFunc
}

@end
