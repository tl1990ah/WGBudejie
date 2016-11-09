//
//  WGCommentCell.m
//  WGBudejie
//
//  Created by taolei on 16/11/9.
//  Copyright © 2016年 taolei. All rights reserved.
//

#import "WGCommentCell.h"
#import "WGCommentFrame.h"
#import "WGComment.h"
#import "WGUser.h"

@interface WGCommentCell()

/** 头像 */
@property (nonatomic, weak) UIImageView *profileImageView;
/** 性别 */
@property (nonatomic, weak) UIImageView *sexImageView;
/** 内容 */
@property (nonatomic, weak) UILabel *contentLabel;
/** 昵称 */
@property (nonatomic, weak) UILabel *usernameLabel;
/** 点赞数 */
@property (nonatomic, weak) UILabel *likeCountLabel;
/** 点赞按钮 */
@property (nonatomic, weak) UIButton *likeBtn;
@end

@implementation WGCommentCell

+ (instancetype)commentCellWithTableView:(UITableView *)tableView
{
    static NSString *Id = @"comment";
    WGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if(!cell){
        cell = [[WGCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
        
        UIImageView *profileImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:profileImageView];
        self.profileImageView = profileImageView;
        
        UIImageView *sexImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:sexImageView];
        self.sexImageView = sexImageView;
        
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.font = [UIFont systemFontOfSize:15];
        contentLabel.numberOfLines = 0;
        [self.contentView addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        UILabel *usernameLabel = [[UILabel alloc] init];
        usernameLabel.font = [UIFont systemFontOfSize:14];
        usernameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:usernameLabel];
        self.usernameLabel = usernameLabel;
        
        UILabel *likeCountLabel = [[UILabel alloc] init];
        likeCountLabel.font = [UIFont systemFontOfSize:14];
        likeCountLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:likeCountLabel];
        self.likeCountLabel = likeCountLabel;
        
        UIButton *likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [likeBtn setImage:[UIImage imageNamed:@"commentLikeButton"] forState:UIControlStateNormal];
        [likeBtn setImage:[UIImage imageNamed:@"commentLikeButtonClick"] forState:UIControlStateHighlighted];
        [self.contentView addSubview:likeBtn];
        self.likeBtn = likeBtn;
    }
    return self;
}

- (void)setCommentFrame:(WGCommentFrame *)commentFrame
{
    _commentFrame = commentFrame;
    WGComment *comment = commentFrame.comment;
    WGUser *user = comment.user;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.likeCount];
    self.likeCountLabel.frame = commentFrame.likeCountFrame;
    
    self.likeBtn.frame = commentFrame.likeBtnFrame;
    
    self.profileImageView.frame = commentFrame.headerIconFrame;
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.sexImageView.frame = commentFrame.sexIconFrame;
    if([user.sex isEqualToString:@"m"]){
        self.sexImageView.image = [UIImage imageNamed:@"Profile_manIcon"];
    }else{
        self.sexImageView.image = [UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    self.contentLabel.text = comment.content;
    self.contentLabel.frame = commentFrame.contentFrame;
    
    self.usernameLabel.text = user.username;
    self.usernameLabel.frame = commentFrame.usernameFrame;
    
    self.likeCountLabel.text = [NSString stringWithFormat:@"%zd",comment.likeCount];
    self.likeCountLabel.frame = commentFrame.likeCountFrame;

}

@end
