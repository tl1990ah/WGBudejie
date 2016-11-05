//
//  WGTabController.m
//  WGBudejie
//
//  Created by taolei on 16/10/18.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTabController.h"
#import "WGNewViewController.h"
#import "WGMeViewController.h"
#import "WGFollowViewController.h"
#import "WGEssenceViewController.h"
#import "WGTabBar.h"
#import "WGNavigationController.h"

@interface WGTabController()

@end

@implementation WGTabController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTabBarItemTitleAttributes];
    
    [self addAllChildVC];
    
    [self setupTabBar];
}

- (void)setupTabBarItemTitleAttributes
{
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    NSMutableDictionary *normalAttribute = [NSMutableDictionary dictionary];
    normalAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    normalAttribute[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttribute = [NSMutableDictionary dictionary];
    selectedAttribute[NSFontAttributeName] = [UIFont systemFontOfSize:14];
    selectedAttribute[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    [tabBarItem setTitleTextAttributes:normalAttribute forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:selectedAttribute forState:UIControlStateSelected];
}

- (void)setupTabBar
{
    WGTabBar *tabBar = [[WGTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

- (void)addAllChildVC
{
    [self addOneChildVC:[[WGNavigationController alloc] initWithRootViewController:[[WGEssenceViewController alloc] init]]
                                    title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self addOneChildVC:[[WGNavigationController alloc] initWithRootViewController:[[WGNewViewController alloc] init]]
                  title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self addOneChildVC:[[WGNavigationController alloc] initWithRootViewController:[[WGFollowViewController alloc] init]]
                  title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self addOneChildVC:[[WGNavigationController alloc] initWithRootViewController:[[WGMeViewController alloc] init]]
                  title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
}

- (void)addOneChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVC.tabBarItem.title = title;
    if(image.length){
        childVC.tabBarItem.image = [UIImage imageNamed:image];
        childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    }
   
    [self addChildViewController:childVC];
}

@end
