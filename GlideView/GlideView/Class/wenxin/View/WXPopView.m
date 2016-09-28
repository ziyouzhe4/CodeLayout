//
//  PopView.m
//  GlideView
//
//  Created by majianjie on 15/12/21.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXPopView.h"

@interface WXPopView()
{
    int i;
}
@property (nonatomic,strong)UIButton *approvBtn;
@property (nonatomic,strong)UIButton *commentBtn;
@property (nonatomic,strong)UIView *lineView;

@property (strong, nonatomic) IBOutlet UIImageView *image1;


@end

@implementation WXPopView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = ColorWithA(30, 32, 40,1);
        self.layer.cornerRadius = 5;
        
        [self setUpBtn];
        
    }
    
    return self;
}

//添加"赞"和"评论"按钮
- (void)setUpBtn
{
    /*添加赞按钮*/
    UIButton *approvBtn = [[UIButton alloc] init];
    self.approvBtn = approvBtn;
    [self addSubview:approvBtn];
    
    /*赞 和 评论 中间的 竖线*/
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    self.lineView = lineView;
    
    
    /*添加评论按钮*/
    UIButton *commentBtn = [[UIButton alloc] init];
    self.commentBtn = commentBtn;
    [self addSubview:commentBtn];
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    CGFloat btnY = 10;
    CGFloat btnW = self.width / 2;
    CGFloat btnH = self.height / 3 * 1.5;
    
    [self setUpapproveBtnAndCommentBtn:self.approvBtn andTitle:@"赞" andX:btnX andY:btnY andW:btnW andH:btnH andImage:@"1"];
    [self.approvBtn addTarget:self action:@selector(appAct:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self setUpapproveBtnAndCommentBtn:self.commentBtn andTitle:@"评论" andX:CGRectGetMaxX(self.approvBtn.frame) andY:btnY andW:CGRectGetWidth(self.approvBtn.frame) andH:CGRectGetHeight(self.approvBtn.frame) andImage:@"tab_icon_wo_hl"];
    [self.commentBtn addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];

    
}

//提取共有的代码

- (void) setUpapproveBtnAndCommentBtn:(UIButton *)btn andTitle:(NSString *)title andX:(CGFloat)x andY:(CGFloat)y andW:(CGFloat)w andH:(CGFloat)h andImage:(NSString *)name
{

    btn.frame = CGRectMake(x,y,w,h);
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.textColor = White;
    btn.titleLabel.font = Small_Font;
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [btn setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
}

/**点赞时候的动画效果*/
- (void)appAct:(UIButton *)sender
{
    NSLog(@"***************增加了一个赞****************");
    
    [self.approvBtn setTitle:(i%2==0?@"取消":@"赞") forState:UIControlStateNormal];
    
    [self.approvBtn setImage:[UIImage imageNamed:(i%2==0?@"2":@"1")] forState:UIControlStateNormal];
    self.image1.layer.contents = (id)[UIImage imageNamed:(i%2==0?@"2":@"1")].CGImage;
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    k.values = @[@(0.1),@(1.0),@(1.5)];
    k.keyTimes = @[@(0.0),@(0.5),@(0.8),@(1.0)];
    k.calculationMode = kCAAnimationLinear;
    
    i++;
    [self.approvBtn.layer addAnimation:k forKey:@"SHOW"];
    [self.image1.layer addAnimation:k forKey:@"SHOW"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSNotification * notice = [NSNotification notificationWithName:@"hidepopView" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    });
}

- (void)commentAction:(UIButton *)sender{
    
    NSLog(@"***************增加了一条评论***************");
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSNotification * notice = [NSNotification notificationWithName:@"hidepopView" object:nil userInfo:nil];
        //发送消息
        [[NSNotificationCenter defaultCenter]postNotification:notice];
        
    });
    
}

@end
