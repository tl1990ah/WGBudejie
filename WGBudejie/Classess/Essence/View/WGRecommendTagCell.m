//
//  WGRecommendTagCell.m
//  WGBudejie
//
//  Created by admin on 16/11/5.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGRecommendTagCell.h"
#import "WGRecommendTag.h"

@interface WGRecommendTagCell()

/** 图标 */
@property (nonatomic, weak) UIImageView *imageListView;
/** 名称 */
@property (nonatomic, weak) UILabel *themeNameLabel;
/** 订阅数*/
@property (nonatomic, weak) UILabel *subNumberLabel;

@property (nonatomic, weak) UIButton *btn;

@end

@implementation WGRecommendTagCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *imageListView = [[UIImageView alloc] init];
        [self.contentView addSubview:imageListView];
        self.imageListView = imageListView;
        
        UILabel *themeNameLabel = [[UILabel alloc] init];
        themeNameLabel.textColor = [UIColor blackColor];
        themeNameLabel.font = [UIFont systemFontOfSize:17];
        [self.contentView addSubview:themeNameLabel];
        self.themeNameLabel = themeNameLabel;
        
        UILabel *subNumberLabel = [[UILabel alloc] init];
        subNumberLabel.textColor = [UIColor lightGrayColor];
        subNumberLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:subNumberLabel];
        self.subNumberLabel = subNumberLabel;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"+订阅" forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"FollowBtnBg"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"FollowBtnBgClick"] forState:UIControlStateHighlighted];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:btn];
        self.btn = btn;
        
    }
    return self;
}

+ (instancetype)recommendTagCellWithTable:(UITableView *)tableView
{
    static NSString *Id = @"recommend";
    WGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if(!cell){
        cell = [[WGRecommendTagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.userInteractionEnabled = YES;
    }
    return cell;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.btn.frame = CGRectMake(WIDTH - 70, 22.5, 50, 25);
    self.imageListView.frame = CGRectMake(20, 15, 50, 50);
    
    self.themeNameLabel.frame = CGRectMake(CGRectGetMaxX(self.imageListView.frame) + 10, 15, 120, 20);
    
    self.subNumberLabel.frame = CGRectMake(self.themeNameLabel.x, CGRectGetMaxY(self.themeNameLabel.frame)+15, 250, 20);
}

- (void)setRecommendTag:(WGRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    
    [self.imageListView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.themeNameLabel.text = recommendTag.theme_name;
    
    if(recommendTag.sub_number >= 10000){
        self.subNumberLabel.text = [NSString stringWithFormat:@"%0.1f万人订阅", recommendTag.sub_number / 10000.0];
    }else{
        self.subNumberLabel.text = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    }
    
}

/**
 *  重写setFrame:的作用: 监听设置cell的frame的过程
 */
- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
