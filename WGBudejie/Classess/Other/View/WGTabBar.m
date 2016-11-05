//
//  WGTabBar.m
//  WGBudejie
//
//  Created by taolei on 16/10/18.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTabBar.h"

@interface WGTabBar()

@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation WGTabBar

- (UIButton *)publishBtn
{
    if(!_publishBtn){
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
    }
    return _publishBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.width / 5;
    CGFloat buttonH = self.height;
    CGFloat tabBarButtonY = 0;
    NSUInteger buttonIndex = 0;
    
    for (UIView *subView in self.subviews) {
        if (subView.class != NSClassFromString(@"UITabBarButton")) continue;
        
        CGFloat tabBarButtonX = buttonIndex * buttonW;
        if(buttonIndex >= 2){
            tabBarButtonX += buttonW;
        }
        subView.frame = CGRectMake(tabBarButtonX, tabBarButtonY, buttonW, buttonH);
        buttonIndex++;
    }
    self.publishBtn.width = buttonW;
    self.publishBtn.height = buttonH;
    self.publishBtn.centerX = self.width * 0.5;
    self.publishBtn.centerY = self.height * 0.5;
}

@end
