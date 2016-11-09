//
//  WGCommentCell.h
//  WGBudejie
//
//  Created by taolei on 16/11/9.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGCommentFrame;

@interface WGCommentCell : UITableViewCell
@property (nonatomic, strong) WGCommentFrame *commentFrame;
+ (instancetype)commentCellWithTableView:(UITableView *)tableView;
@end
