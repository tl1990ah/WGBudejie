//
//  WGLoginRegisterViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/19.
//  Copyright © 2016年 taolei. All rights reserved.
//

#define WGBtnEdge  (self.view.width - 3 * 80 - 2 * 20) * 0.5
#define ThreeBtnW 80
#define ThreeBtnH 100

#import "WGLoginRegisterViewController.h"

@interface WGLoginRegisterViewController ()
@property (nonatomic, weak) UITextField *nameTextField;
@property (nonatomic, weak) UITextField *pwdTextField;
@property (nonatomic, weak) UIView *loginView;
@property (nonatomic, weak) UIView *registerView;
@property (nonatomic, weak) UIButton *registerBtn;
@property (nonatomic, weak) UIImageView *textFieldImage;
@end

@implementation WGLoginRegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupLoginView];
    
    [self setupRegisterView];
    
    [self setupOtherView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupLoginView
{
    // 1.设置背景图片
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_background"]];
    background.frame = self.view.bounds;
    [self.view addSubview:background];
    
    // 2.设置关闭按钮
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"login_close_icon"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(0, 50, 60, 20);
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeBtn];
    
    // 3.设置登录和注册的切换按钮
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    registerBtn.frame = CGRectMake(WIDTH - 20 -80, 50, 80, 20);
    registerBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(showRegisterView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    self.registerBtn = registerBtn;
    
    UIView *loginView = [[UIView alloc] init];
    loginView.frame = CGRectMake(0, CGRectGetMaxY(registerBtn.frame), WIDTH, 280);
    loginView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:loginView];
    self.loginView = loginView;
    
    // 4.设置文本框的背景图片和文本框
    UIImageView *textFieldImage = [[UIImageView alloc] initWithImage:
                                    [UIImage imageNamed:@"login_rgister_textfield_bg"]];
    textFieldImage.frame = CGRectMake((WIDTH - 266)*0.5, 40, 266, 92);
    [loginView addSubview:textFieldImage];
    self.textFieldImage = textFieldImage;
    
    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.tintColor = [UIColor whiteColor];
    nameTextField.textColor = [UIColor whiteColor];
    nameTextField.placeholder = @"账号";
    nameTextField.frame = CGRectMake(textFieldImage.x + 10, textFieldImage.y + 5, textFieldImage.width - 20, 35);
    [loginView addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.frame = CGRectMake(textFieldImage.x + 10, CGRectGetMaxY(nameTextField.frame)+10, textFieldImage.width - 20, 35);
    pwdTextField.secureTextEntry = YES;
    pwdTextField.placeholder = @"密码";
    pwdTextField.tintColor = [UIColor whiteColor];
    pwdTextField.textColor = [UIColor whiteColor];
    [loginView addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    // 5.设置登录按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake((WIDTH - 266)*0.5, CGRectGetMaxY(textFieldImage.frame)+20, 266, 40);
    loginBtn.layer.cornerRadius = 5.0;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_button_click"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [loginView addSubview:loginBtn];
    
    // 6.设置忘记密码在按钮
    UIButton *forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    forgetPwdBtn.frame = CGRectMake(WIDTH - ((WIDTH - 266)*0.5) - 80, CGRectGetMaxY(loginBtn.frame)+20, 80, 20);
    forgetPwdBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    forgetPwdBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [forgetPwdBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [forgetPwdBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [loginView addSubview:forgetPwdBtn];
}

- (void)setupRegisterView
{
    UIView *registerView = [[UIView alloc] init];
    registerView.frame = CGRectMake(WIDTH, CGRectGetMaxY(self.registerBtn.frame), WIDTH, 280);
    registerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:registerView];
    self.registerView = registerView;
    
    // 4.设置文本框的背景图片和文本框
    UIImageView *textFieldImage = [[UIImageView alloc] initWithImage:
                                   [UIImage imageNamed:@"login_rgister_textfield_bg"]];
    textFieldImage.frame = CGRectMake((WIDTH - 266)*0.5, 40, 266, 92);
    [registerView addSubview:textFieldImage];
    
    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.tintColor = [UIColor whiteColor];
    nameTextField.textColor = [UIColor whiteColor];
    nameTextField.placeholder = @"请输入手机号";
    nameTextField.frame = CGRectMake(textFieldImage.x + 10, textFieldImage.y + 5, textFieldImage.width - 20, 35);
    [registerView addSubview:nameTextField];
    self.nameTextField = nameTextField;
    
    UITextField *pwdTextField = [[UITextField alloc] init];
    pwdTextField.frame = CGRectMake(textFieldImage.x + 10, CGRectGetMaxY(nameTextField.frame)+10, textFieldImage.width - 20, 35);
    pwdTextField.secureTextEntry = YES;
    pwdTextField.placeholder = @"设置密码";
    pwdTextField.tintColor = [UIColor whiteColor];
    pwdTextField.textColor = [UIColor whiteColor];
    [registerView addSubview:pwdTextField];
    self.pwdTextField = pwdTextField;
    
    // 5.设置注册按钮
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake((WIDTH - 266)*0.5, CGRectGetMaxY(textFieldImage.frame)+20, 266, 40);
    loginBtn.layer.cornerRadius = 5.0;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_button"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login_register_button_click"] forState:UIControlStateHighlighted];
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [registerView addSubview:loginBtn];
}

- (void)setupOtherView
{
    NSArray *title = @[@"QQ登录", @"微博登录", @"腾讯微博"];
    NSArray *imageName = @[@"login_QQ_icon", @"login_sina_icon", @"login_tecent_icon"];
    NSArray *heightImageName = @[@"login_QQ_icon_click", @"login_sina_icon_click", @"login_tecent_icon_click"];
    UIView *threeLoginView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT - 40 - ThreeBtnH, WIDTH, ThreeBtnH)];
    [self.view addSubview:threeLoginView];
    
    for (int index = 0; index < 3 ; index++) {
        UIButton *threeLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [threeLoginBtn setImage:[UIImage imageNamed:imageName[index]] forState:UIControlStateNormal];
        [threeLoginBtn setImage:[UIImage imageNamed:heightImageName[index]] forState:UIControlStateHighlighted];
        [threeLoginBtn setTitle:title[index] forState:UIControlStateNormal];
        threeLoginBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [threeLoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [threeLoginBtn.titleLabel sizeToFit];
        threeLoginBtn.frame = CGRectMake(20 + index * (ThreeBtnW + WGBtnEdge), 0, ThreeBtnW, ThreeBtnH);
        [threeLoginBtn setImageEdgeInsets:UIEdgeInsetsMake(-30, 5, 0, 0)];
        [threeLoginBtn setTitleEdgeInsets:UIEdgeInsetsMake(80, -70, 0, 0)];
        [threeLoginView addSubview:threeLoginBtn];
    }
    
    // 中间的文字
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((WIDTH - 80)/2,threeLoginView.y - 40, 80, 20)];
    titleLabel.text = @"快速登录";
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLabel];
    
    // 左边的横线
    UIImageView *leftLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_left_line"]];
    leftLine.frame = CGRectMake(self.textFieldImage.x -5, titleLabel.centerY - 0.5, leftLine.image.size.width, 1);
    [self.view addSubview:leftLine];
    
    // 右边的横线
    UIImageView *rightLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_register_right_line"]];
    rightLine.frame = CGRectMake(WIDTH - leftLine.width - (WIDTH - 266)*0.5, leftLine.y, rightLine.image.size.width, 1);
    [self.view addSubview:rightLine];

}

- (void)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showRegisterView:(UIButton *)button
{
    [self.view endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        if(self.loginView.x == 0){
            button.selected = NO;
            self.loginView.x = -WIDTH;
            self.registerView.x = 0;
            [self.registerBtn setTitle:@"已有账号?" forState:UIControlStateNormal];
        }else{
            button.selected = YES;
            self.loginView.x = 0;
            self.registerView.x = WIDTH;
            [self.registerBtn setTitle:@"注册账号" forState:UIControlStateNormal];
        }
    }];
    
}

- (void)dealloc
{
    WGLog(@"WGLoginRegisterViewController被销毁了");
}

@end
