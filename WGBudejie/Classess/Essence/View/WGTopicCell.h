//
//  WGTopicCell.h
//  WGBudejie
//
//  Created by taolei on 16/10/25.
//  Copyright © 2016年 taolei. All rights reserved.
//  自定义一个帖子单元格

#import <UIKit/UIKit.h>
@class WGTopicFrame;
@interface WGTopicCell : UITableViewCell

@property (nonatomic, strong) WGTopicFrame *topicFrame;

+ (instancetype)cellWithTable:(UITableView *)tableView ;
@end
