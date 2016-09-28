//
//  WXStatusOriginalView.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusOriginalView.h"
#import "WXStatusPhotosView.h"
#import "WXStatusInfo.h"
#import "WXStatusOriginalFrame.h"
#import "WXUserInfo.h"
#import "UIImageView+WebCache.h"
#import "WXPopView.h"
#import "UIView+Extension.h"

@interface WXStatusOriginalView()

/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *textLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/**配图相册*/
@property (nonatomic,strong) WXStatusPhotosView *photosView;
/** "点赞"的按钮*/
@property (nonatomic,strong)UIButton *approvBtn;

/** 点赞后的弹出框*/
@property (nonatomic,strong) WXPopView *popView;

/** 全屏的遮罩View*/
@property (nonatomic,strong) UIButton *bgView;



@end

@implementation WXStatusOriginalView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 初始化子控件
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = HMStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = HMStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = HMStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = HMStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 6.配图相册
        WXStatusPhotosView *photosView = [[WXStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
      
        // 7. 点赞的button
        UIButton *approvBtn = [[UIButton alloc] init];
        [self addSubview:approvBtn];
        self.approvBtn = approvBtn;
        //添加长点击事件
        [self.approvBtn addTarget:self action:@selector(appAction:) forControlEvents:UIControlEventTouchUpInside];
       
        // 8 .点赞的弹出框
        self.popView = [[WXPopView alloc] init];
        self.popView.hidden = YES;
        [self addSubview:self.popView];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver: self
               selector: @selector(hidepopView:)
                   name: @"hidepopView"
                 object: nil];
    
    }
    
    return self;
}

- (void)setOriginalFrame:(WXStatusOriginalFrame *)originalFrame
{
        _originalFrame = originalFrame;
        
        self.frame = originalFrame.frame;
        
        // 取出微信数据
        WXStatusInfo *status = originalFrame.status;
        // 取出用户数据
        WXUserInfo *user = status.user;
    
        // 1.头像
        self.iconView.frame = originalFrame.iconFrame;
        [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
        

        // 2.昵称
        self.nameLabel.text = user.name;
        self.nameLabel.frame = originalFrame.nameFrame;
        
        // 3.正文（内容）
        self.textLabel.text = status.text;
        self.textLabel.frame = originalFrame.textFrame;
    
        // 6.配图相册
        if (status.pic_urls.count) {
            self.photosView.frame = originalFrame.photosFrame;
            self.photosView.hidden = NO;
            self.photosView.pic_urls = status.pic_urls;
        }else{
            self.photosView.hidden = YES;
        }
    
#warning 需要时刻根据现在的时间字符串来计算时间label的frame
        // 4.时间
        NSString *time = status.created_at;
        self.timeLabel.text = time; // 刚刚 --> 1分钟前 --> 10分钟前
        CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
        CGFloat timeY = 0;
        if (status.pic_urls.count) {
            timeY = CGRectGetMaxY(self.photosView.frame) + HMStatusCellInset * 0.25;
        }else{
            timeY = CGRectGetMaxY(self.textLabel.frame) + HMStatusCellInset * 0.25;

        }
        CGSize timeSize = [time sizeWithFont:HMStatusOrginalTimeFont];
        self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
        
        // 5.来源
        self.sourceLabel.text = status.source;
        CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HMStatusCellInset;
        CGFloat sourceY = timeY;
        CGSize sourceSize = [status.source sizeWithFont:HMStatusOrginalSourceFont];
        self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};

        // 7.点赞按钮
        [self.approvBtn setImage:[UIImage imageNamed:@"compose_camerabutton_background_highlighted"] forState:UIControlStateNormal];
        self.approvBtn.adjustsImageWhenHighlighted = NO;
        self.approvBtn.frame = originalFrame.approvFrame;
    
    
        CGRect frame = CGRectMake(self.approvBtn.center.x, self.approvBtn.center.y - 20, 170, 38);
        self.popView.frame = frame;
        self.popView.hidden = YES;
    
    
}

/*点赞按钮点击事件*/
- (void)appAction:(UIButton *)btn
{
    if (self.popView.hidden) {//出现
        self.popView.alpha = 1;
        self.popView.hidden = !self.popView.hidden;
        
        [UIView animateWithDuration:0.25 animations:^{
            double centerY = self.approvBtn.center.y;
            self.popView.center = CGPointMake(CGRectGetMinX(self.approvBtn.frame) - 90, centerY);
        }];
        
    }else{ //消失
        [self hidepopView];
    }
    
}

- (void)hidepopView:(id)center
{
    [self hidepopView];
}

- (void)hidepopView
{
    [self.bgView removeFromSuperview];
    [UIView animateWithDuration:0.20 animations:^{
        self.popView.alpha = 0.5;
        double centerY = self.approvBtn.center.y;
        self.popView.center = CGPointMake(CGRectGetMaxX(self.approvBtn.frame), centerY);
    } completion:^(BOOL finished) {
        self.popView.hidden = YES;
    }];
}

@end
