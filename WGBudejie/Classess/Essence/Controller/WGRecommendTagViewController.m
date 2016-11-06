//
//  WGRecommendTagViewController.m
//  WGBudejie
//
//  Created by admin on 16/11/5.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGRecommendTagViewController.h"
#import "WGRecommendTagCell.h"
#import "WGRecommendTag.h"
#import "MJExtension.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"

@interface WGRecommendTagViewController ()
/** 所有的标签数据(数组中存放的都是XMGRecommendTag模型) */
@property (nonatomic, strong) NSArray<WGRecommendTag *> *recommendTags;
@end

@implementation WGRecommendTagViewController

#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 标题设置
    self.navigationItem.title = @"推荐标签";
    
    self.tableView.backgroundColor = WGCommonBgColor;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 70.0;
    
    [self loadNewRecommandTags];
}

- (void)loadNewRecommandTags
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    [MBProgressHUD showMessage:@"正在加载"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.recommendTags = [WGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [MBProgressHUD hideHUD];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [MBProgressHUD showError:@"网络繁忙，请稍后再试！"];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recommendTags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGRecommendTagCell *cell = [WGRecommendTagCell recommendTagCellWithTable:tableView];
    cell.recommendTag = self.recommendTags[indexPath.row];
    return cell;
}

@end
