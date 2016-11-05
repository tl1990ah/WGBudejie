//
//  WGEssenceViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/18.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGEssenceViewController.h"
#import "WGAllViewController.h"
#import "WGWordViewController.h"
#import "WGVideoViewController.h"
#import "WGVoiceViewController.h"
#import "WGPictureViewController.h"
#import "WGWordViewController.h"
#import "WGTopicViewController.h"
#import "WGTopic.h"

@interface WGEssenceViewController ()<UIScrollViewDelegate>
/** 当前选中的标题按钮 */
@property (nonatomic, weak) UIButton *selectedTitleBtn;
/** 标题按钮底部的指示器 */
@property (nonatomic, weak) UIView *indicatorView;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) UIView *titleView;
@end

@implementation WGEssenceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNavBar];
    
    [self addAllChildVC];
    
    [self setupVCScrollView];
    
    [self setupTitleView];
    
    // 添加默认子控制器的view
    [self addOneVcView];
}

/**
 *   设置导航栏内容
 */
- (void)setupNavBar
{
    self.view.backgroundColor = WGCommonBgColor;
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
}

/**
 *   设置scrollView
 */
- (void)setupVCScrollView
{
    //  禁止自动调整scrollView的内边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:scrollView];
    
    NSUInteger count = self.childViewControllers.count;
    scrollView.contentSize = CGSizeMake(WIDTH * count, 0);
    self.scrollView = scrollView;
}

/**
 *   添加子控制器
 */
- (void)addAllChildVC
{
    WGAllViewController *allViewController = [[WGAllViewController alloc] init];
    allViewController.title = @"全部";
    //allViewController.type = @1;
    [self addChildViewController:allViewController];

    WGVideoViewController *videoViewController = [[WGVideoViewController alloc] init];
    videoViewController.title = @"视频";
    //videoViewController.type = @41;
    [self addChildViewController:videoViewController];
    
    WGVoiceViewController *voiceViewController = [[WGVoiceViewController alloc] init];
    voiceViewController.title = @"音频";
    //voiceViewController.type = @31;
    [self addChildViewController:voiceViewController];
    
    WGPictureViewController *pictureViewController = [[WGPictureViewController alloc] init];
    pictureViewController.title = @"图片";
    //pictureViewController.type = @10;
    [self addChildViewController:pictureViewController];
    
    WGWordViewController *wordViewController = [[WGWordViewController alloc] init];
    wordViewController.title = @"段子";
    //wordViewController.type = @29;
    [self addChildViewController:wordViewController];
}

/**
 *   添加子控制器的 view
 */
- (void)addOneVcView
{
    NSUInteger index = self.scrollView.contentOffset.x / WIDTH;
    UIViewController *childVC = self.childViewControllers[index];
    
    if([childVC isViewLoaded]) return;
    
    UITableView *tableView = (UITableView *)childVC.view;
    tableView.frame = self.scrollView.bounds;
    [self.scrollView addSubview:tableView];
}

/**
 *  设置标题栏
 */
- (void)setupTitleView
{
    // 标题栏
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titleView.frame = CGRectMake(0, 64, WIDTH, 35);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    
    // 添加标题
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSUInteger count = titles.count;
    CGFloat titleBtnW = self.view.width / count;
    CGFloat titleBtnH = titleView.height;
    for(NSUInteger i = 0; i < count; i++) {
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleButton setHighlighted:NO];
        titleButton.tag = i;
        [titleView addSubview:titleButton];
        [titleButton setTitle:titles[i] forState:UIControlStateNormal];
        titleButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [titleButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleButton.frame = CGRectMake(titleBtnW * i, 0, titleBtnW, titleBtnH);
        [titleButton addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    UIButton *firstTitleButton = titleView.subviews.firstObject;
    
    // 底部指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.height = 1;
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.y = titleView.height - indicatorView.height;
    [titleView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    [firstTitleButton.titleLabel sizeToFit];
    indicatorView.centerX = firstTitleButton.centerX;
    indicatorView.width = firstTitleButton.titleLabel.width;
    [self titleBtnClick:firstTitleButton];
}

- (void)titleBtnClick:(UIButton *)selectBtn
{
    self.selectedTitleBtn.selected = NO;
    selectBtn.selected = YES;
    self.selectedTitleBtn = selectBtn;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.centerX = selectBtn.centerX;
        self.indicatorView.width = selectBtn.titleLabel.width;
    }];
    
    CGFloat offsetX = selectBtn.tag * WIDTH;
    CGPoint offset = CGPointMake(offsetX, 0);
    [self.scrollView setContentOffset:offset animated:YES];
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self addOneVcView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger index = self.scrollView.contentOffset.x / WIDTH;
    UIButton *selectedBtn = self.titleView.subviews[index];
    [self titleBtnClick:selectedBtn];
    
    [self addOneVcView];
}

- (void)tagClick
{
    WGLogFunc
}

@end
