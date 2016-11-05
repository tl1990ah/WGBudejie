//
//  WGSettingViewController.m
//  WGBudejie
//
//  Created by taolei on 16/10/19.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGSettingViewController.h"

@interface WGSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation WGSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.automaticallyAdjustsScrollViewInsets = NO;  //默认时YES
    [self setupNavBar];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

- (void)setupNavBar
{
    self.view.backgroundColor = WGRandomColor;
    self.navigationItem.title = @"设置";
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if(!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Id];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@--第%zd行",[self class], indexPath.row];
    return cell;
}


@end
