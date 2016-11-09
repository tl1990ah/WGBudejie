//
//  WGCommentViewController.m
//  WGBudejie
//
//  Created by taolei on 16/11/8.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGCommentViewController.h"
#import "WGCommentCell.h"
#import "WGCommentFrame.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "WGTopic.h"
#import "WGComment.h"
#import "WGTopicCell.h"
#import "WGTopicFrame.h"

#define KBoardH 44    //  底部工具条高度

@interface WGCommentViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) UIImageView *textFieldImage;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UITableView *commentTableView;

/** 请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;

/** 最新评论 */
@property (nonatomic, strong) NSMutableArray *latestComments;

/** 最热评论 */
@property (nonatomic, strong) NSMutableArray *hottestComments;
@end

@implementation WGCommentViewController

- (AFHTTPSessionManager *)manager
{
    if(!_manager){
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self setupBase];
    [self setupTableView];
    
    [self setupRefresh];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupRefresh
{
    self.commentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.commentTableView.mj_header beginRefreshing];
    
    self.commentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
}

- (NSMutableArray *)commentsFramesWithComments:(NSArray *)comments
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WGComment *comment in comments) {
        WGCommentFrame *commentFrame = [[WGCommentFrame alloc] init];
        commentFrame.comment = comment;
        [frames addObject:commentFrame];
    }
    return frames;
}

/**
 *   加载最新的评论
 */
- (void)loadNewComment
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //  配置请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicFrame.topic.ID;
    params[@"hot"] = @"1";
    
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.commentTableView.mj_header endRefreshing];
        [responseObject writeToFile:@"/Users/taolei/Desktop/comment.plist" atomically:YES];
        
        NSArray *latesComments = [WGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        self.latestComments = [self commentsFramesWithComments:latesComments];
        
        NSArray *hotComments = [WGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.hottestComments = [self commentsFramesWithComments:hotComments];
        
        [self.commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.commentTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreComments
{
    // 取消之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    //  配置请求参数
    WGCommentFrame *commentFrame = self.latestComments.lastObject;
    WGComment *comment = commentFrame.comment;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topicFrame.topic.ID;
    params[@"lastcid"] = comment.ID;
   
    // 发送请求
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [responseObject writeToFile:@"/Users/taolei/Desktop/comment.plist" atomically:YES];
        [self.commentTableView.mj_footer endRefreshing];
        NSArray *latesComments = [WGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        NSMutableArray *comments = [self commentsFramesWithComments:latesComments];
        [self.latestComments addObjectsFromArray:comments];
        
//        NSArray *hotComments = [WGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
//        self.hottestComments = [self commentsFramesWithComments:hotComments];
//        
        [self.commentTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.commentTableView.mj_footer endRefreshing];
    }];
}

/**
 *  键盘即将弹出
 */
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 动画持续时间
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    //键盘的frame
    CGRect keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat offsetY = keyboardFrame.origin.y - HEIGHT;
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        self.textFieldImage.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];
}

/**
 *  设置标题和右边的Item
 */
- (void)setupBase
{
    self.view.backgroundColor = WGCommonBgColor;
    self.navigationItem.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
}

/**
 *  添加UITableView和输入框
 */
- (void)setupTableView
{
    UITableView *commentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - KBoardH) style:UITableViewStylePlain];
    commentTableView.delegate = self;
    commentTableView.backgroundColor = [UIColor clearColor];
    commentTableView.dataSource = self;
    commentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:commentTableView];  // 默认情况下UITableView的内容向下平移64
    self.commentTableView = commentTableView;
    
    WGTopicCell *cell = [[WGTopicCell alloc] init];
    cell.topicFrame = self.topicFrame;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.height = self.topicFrame.cellHeight + 10;
    commentTableView.tableHeaderView = headerView;
    cell.frame = CGRectMake(0, 10, WIDTH, self.topicFrame.cellHeight);
    [headerView addSubview:cell];

    UIImageView *textFieldImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comment-bar-bg"]];
    textFieldImage.frame = CGRectMake(0, HEIGHT - KBoardH, WIDTH, KBoardH);
    textFieldImage.userInteractionEnabled = YES; // 不设置该属性， 子控件不能响应点击事件
    textFieldImage.backgroundColor = [UIColor blueColor];
    [self.view addSubview:textFieldImage];
    self.textFieldImage = textFieldImage;
    
    UIButton *voiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    voiceBtn.frame = CGRectMake(0, 0, 44, 44);
    [voiceBtn setImage:[UIImage imageNamed:@"comment-bar-voice"] forState:UIControlStateNormal];
    [voiceBtn setImage:[UIImage imageNamed:@"comment-bar-voice-click"] forState:UIControlStateHighlighted];
    [textFieldImage addSubview:voiceBtn];
    
    UIButton *textBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    textBtn.frame = CGRectMake(WIDTH - 44, 0, 44, 44);
    [textBtn setImage:[UIImage imageNamed:@"comment_bar_at_icon"] forState:UIControlStateNormal];
    [textBtn setImage:[UIImage imageNamed:@"comment_bar_at_icon_click"] forState:UIControlStateHighlighted];
    [textFieldImage addSubview:textBtn];
    
    CGFloat textFieldX = CGRectGetMaxX(voiceBtn.frame) + 5;
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(textFieldX, 5, WIDTH - 2 *textFieldX, 34)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.placeholder = @"写评论...";
    textField.font = [UIFont systemFontOfSize:14];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    [textFieldImage addSubview:textField];
    self.textField = textField;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(self.hottestComments){
        return 2;
    }else if(self.latestComments){
        return 1;
    }else{
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0 && self.hottestComments.count){
        return self.hottestComments.count;
    }else{
        return self.latestComments.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WGCommentCell *cell = [WGCommentCell commentCellWithTableView:tableView];
    NSArray *comments = self.latestComments;
    if(indexPath.section == 0 && self.hottestComments.count){
        comments = self.hottestComments;
    }
    WGCommentFrame *commentFrame = comments[indexPath.row];
    cell.commentFrame = commentFrame;
    return cell;
}

#pragma mark UITableViewDelegate
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if(section == 0 && self.hottestComments.count){
        return @"最热评论";
    }
    return @"最新评论";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *comments = self.latestComments;
    if(indexPath.section == 0 && self.hottestComments.count){
        comments = self.hottestComments;
    }

    WGCommentFrame *commentFrame = comments[indexPath.row];
    return commentFrame.rowHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    if([self.textField becomeFirstResponder]){
//        [self.textField resignFirstResponder];
//    }
    [self.view endEditing:YES];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
