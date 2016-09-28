//
//  HMComposeToolbar.m
//  majianjie
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2015年 majianjie. All rights reserved.
//

#import "HMComposeToolbar.h"
#import "UIImage+Extension.h"
#import "UIView+Extension.h"

@implementation HMComposeToolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithName:@"compose_toolbar_background"]];
        
        // 添加所有的子控件
        [self addButtonWithIcon:@"compose_trendbutton_background" highIcon:@"compose_trendbutton_background_highlighted" tag:HMComposeToolbarButtonTypeTrend];
        [self addButtonWithIcon:@"compose_camerabutton_background" highIcon:@"compose_camerabutton_background_highlighted" tag:HMComposeToolbarButtonTypeCamera];
        [self addButtonWithIcon:@"compose_toolbar_picture" highIcon:@"compose_toolbar_picture_highlighted" tag:HMComposeToolbarButtonTypePicture];
        [self addButtonWithIcon:@"compose_emoticonbutton_background" highIcon:@"compose_emoticonbutton_background_highlighted" tag:HMComposeToolbarButtonTypeEmotion];
        [self addButtonWithIcon:@"compose_mentionbutton_background" highIcon:@"compose_mentionbutton_background_highlighted" tag:HMComposeToolbarButtonTypeMention];
    }
    return self;
}

/**
 *  添加一个按钮
 *
 *  @param icon     默认图标
 *  @param highIcon 高亮图标
 */
- (void)addButtonWithIcon:(NSString *)icon highIcon:(NSString *)highIcon tag:(HMComposeToolbarButtonType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    [self addSubview:button];
}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(composeTool:didClickedButton:)]) {
        [self.delegate composeTool:self didClickedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat buttonW = self.width / count;
    CGFloat buttonH = self.height;
    for (int i = 0; i<count; i++) {
        UIButton *button = self.subviews[i];
        button.y = 0;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}

@end
