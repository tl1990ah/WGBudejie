//
//  WGRecommendTagCell.h
//  WGBudejie
//
//  Created by admin on 16/11/5.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WGRecommendTag;

@interface WGRecommendTagCell : UITableViewCell

@property (nonatomic, copy) WGRecommendTag *recommendTag;

+ (instancetype)recommendTagCellWithTable:(UITableView *)tableView ;
@end
