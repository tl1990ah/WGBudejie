//
//  WGNewViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/18.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGNewViewController.h"

@interface WGNewViewController ()

@end

@implementation WGNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setNavBar];
}

- (void)setNavBar
{
    self.view.backgroundColor = WGRandomColor;
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
}

@end
