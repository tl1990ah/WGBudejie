//
//  WGTopicViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/31.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGTopicViewController.h"
#import "AFNetworking.h"
#import "WGTopic.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "WGTopicFrame.h"
#import "WGTopicCell.h"

@interface WGTopicViewController ()
@property (nonatomic, strong) NSMutableArray<WGTopicFrame *> *topicArr;
@property (nonatomic, copy) NSString *maxtime;
@end

@implementation WGTopicViewController

- (WGTopicType)type
{
    return 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(64 + 35, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = WGCommonBgColor;
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];

}

- (NSMutableArray *)topicsFramesWithTopics:(NSArray *)topics
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WGTopic *topic in topics) {
        WGTopicFrame *topicFrame = [[WGTopicFrame alloc] init];
        topicFrame.topic = topic;
        [frames addObject:topicFrame];
    }
    return frames;
}

- (void)loadNewTopics
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    
    AFHTTPSessionManager *maager = [AFHTTPSessionManager manager];
    [maager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *topicArrTemp = [WGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        self.topicArr = [self topicsFramesWithTopics:topicArrTemp];
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreTopics
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"maxtime"] = self.maxtime;
    
    AFHTTPSessionManager *maager = [AFHTTPSessionManager manager];
    [maager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        [responseObject writeToFile:@"/Users/taolei/Desktop/data.plist" atomically:YES];
        self.maxtime = responseObject[@"info"][@"maxtime"];
        NSArray *topics = [WGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        NSMutableArray *topicFrameArr = [self topicsFramesWithTopics:topics];
        [self.topicArr addObjectsFromArray:topicFrameArr];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.topicArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGTopicCell *cell = [WGTopicCell cellWithTable:tableView];
    //WGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topic"];
    WGTopicFrame *topicFrame = self.topicArr[indexPath.row];
    WGTopic *topic = topicFrame.topic;
    WGLog(@"%@---%@---%f",topic.name, topic.large_image, topic.height);
    cell.topicFrame = topicFrame;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGTopicFrame *topicFrame = self.topicArr[indexPath.row];
    CGFloat height = topicFrame.cellHeight;
    //NSLog(@"%f",height);
    return height;
}

@end
