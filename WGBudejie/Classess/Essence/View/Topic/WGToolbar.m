//
//  WGToolbar.m
//  WGBudejie
//
//  Created by taolei on 16/10/26.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGToolbar.h"
#import "WGTopic.h"

@interface WGToolbar()
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers
;
@property (nonatomic, weak) UIButton *repostsBtn;
@property (nonatomic, weak) UIButton *commentsBtn;
@property (nonatomic, weak) UIButton *attitudesBtn;
@property (nonatomic, weak) UIButton *stepBtn;
@property (nonatomic, weak) UIView *topLine;
@end

@implementation WGToolbar

- (NSMutableArray *)dividers
{
    if (_dividers == nil) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

- (NSMutableArray *)btns
{
    if(_btns == nil){
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *topLine = [[UIView alloc] init];
        topLine.backgroundColor = WGCommonBgColor;
        [self addSubview:topLine];
        self.topLine = topLine;
        
        self.attitudesBtn = [self setupBtnWithIcon:@"mainCellDing" highIcon:@"mainCellDingClick" title:@"赞"];
        self.stepBtn = [self setupBtnWithIcon:@"mainCellCai" highIcon:@"mainCellCaiClick" title:@"踩"];
        self.repostsBtn = [self setupBtnWithIcon:@"mainCellShare" highIcon:@"mainCellShareClick" title:@"分享"];
        self.commentsBtn = [self setupBtnWithIcon:@"mainCellComment" highIcon:@"mainCellCommentClick" title:@"评论"];
        
        [self setupDivider];
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topLine.frame = CGRectMake(0, 0, WIDTH, 1);
    NSUInteger count = self.btns.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (int index = 0; index < count; index ++) {
        UIButton *btn = self.btns[index];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;
        btn.x = index * btnW;
    }
    
    CGFloat dividerFirstX = WIDTH / (self.dividers.count + 1);
    for (int i = 0; i < self.dividers.count; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = 29;
        divider.centerX = (i + 1) * dividerFirstX;
        divider.y = CGRectGetMaxY(self.topLine.frame) + 3;
    }
}

- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"cell-button-line"];
    divider.contentMode = UIViewContentModeCenter;
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

- (void)setTopic:(WGTopic *)topic
{
    _topic = topic;
    
    [self setupBtnTitle:self.attitudesBtn count:topic.ding defaultTitle:@"赞"];
    [self setupBtnTitle:self.stepBtn count:topic.cai defaultTitle:@"踩"];
    [self setupBtnTitle:self.repostsBtn count:topic.repost defaultTitle:@"分享"];
    [self setupBtnTitle:self.attitudesBtn count:topic.comment defaultTitle:@"评论"];
}

- (UIButton *)setupBtnWithIcon:(NSString *)icon highIcon:(NSString *)highIcon title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highIcon] forState:UIControlStateHighlighted];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}

- (void)setupBtnTitle:(UIButton *)button count:(NSUInteger)count defaultTitle:(NSString *)defaultTitle
{
    if (count >= 10000) { // [10000, 无限大)
        defaultTitle = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
        // 用空串替换掉所有的.0
        defaultTitle = [defaultTitle stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (count > 0) { // (0, 10000)
        defaultTitle = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:defaultTitle forState:UIControlStateNormal];
}
@end
