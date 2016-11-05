//
//  UIBarButtonItem+WGExtention.m
//  WGBudejie
//
//  Created by taolei on 16/10/19.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "UIBarButtonItem+WGExtention.h"

@implementation UIBarButtonItem (WGExtention)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [backButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [backButton sizeToFit];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:backButton];
}
@end
