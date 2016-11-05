//
//  UIBarButtonItem+WGExtention.h
//  WGBudejie
//
//  Created by taolei on 16/10/19.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WGExtention)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
