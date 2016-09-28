//
//  DeliverMenu.m
//  ddtc
//
//  Created by he on 15/11/6.
//  Copyright © 2015年 丁丁停车. All rights reserved.
//

#import "DeliverMenu.h"

@interface DeliverMenu ()

@property (nonatomic,weak)UIButton * oldBtn;
/** 下线 */
@property (weak, nonatomic) UIView *bottomLineView;


@end

@implementation DeliverMenu
- (NSMutableArray *)btnArr
{
    if (_btnArr == nil) {
        _btnArr = [NSMutableArray array];
    }
    return _btnArr;
}
- (NSArray *)titleA
{
    if (_titleA == nil) {
        _titleA = [NSArray array];
    }
    return _titleA;
}



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.height = 35;
        self.backgroundColor = [UIColor whiteColor];
        [self setupControls];
    }
    return self;
}

- (void)setupControls
{
    NSArray * titleArr = @[@"微博哒",@"微信哒",@"充电哒",@"呵呵哒"];
    self.titleA = titleArr;

    UIView * bottomLineView = [[UIView alloc]init];
    self.bottomLineView = bottomLineView;
    bottomLineView.backgroundColor = HexColor(Color_AlertBGView);
    [self addSubview:bottomLineView];
    
    for (int i = 0; i < titleArr.count; i++) {
        UIButton * btn = [self setupBtn];
        btn.tag = i;
        if (i == 0) {
            [self btnClick:btn];
        }
        
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.btnArr addObject:btn];
        [self addSubview:btn];
    }
}

- (UIButton *)setupBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:HexColor(Color_PlaceholderLabel) forState:UIControlStateNormal];
    [btn setTitleColor:HexColor(Color_KeywordLabel) forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = SetFont(Font_IndexSign);
    return btn;
}

- (void)btnClick:(UIButton *)sender {
    [self btnRefre:sender];
    
    if ([self.delegate respondsToSelector:@selector(deliverMenu:index:)]) {
        [self.delegate deliverMenu:self index:sender.tag];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLineView.centerX = sender.centerX;
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.width / self.titleA.count;
    
    if (self.subviews.count == 0 || self.subviews.count < 4) {
        return;
    }
    
    for (int i = 0; i < self.btnArr.count; i++) {
        UIButton * btn = self.btnArr[i];
        CGFloat btnX = i * width;
        btn.frame = CGRectMake(btnX, 0, width, self.height);
    }
    
    self.bottomLineView.frame = CGRectMake(width / self.titleA.count, self.height - 2, width / 2, 2);
    
}

#pragma mark - event response
- (void)btnRefre:(UIButton *)sender
{
    self.oldBtn.selected = NO;
    sender.selected = YES;
    self.oldBtn = sender;
}

#pragma mark - private events
- (void)setBottomLineCenterX:(CGFloat)centerX
{
    self.bottomLineView.centerX = centerX;
}

@end
