//
//  WXStatusDetailView.m
//  GlideView
//
//  Created by majianjie on 15/12/16.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusDetailView.h"
#import "WXStatusOriginalView.h"
#import "WXStatusApprovingView.h"
#import "WXStatusCommentView.h"
#import "WXStatusDetailFrame.h"
#import "WXStatusOriginalFrame.h"


@interface WXStatusDetailView()

@property (nonatomic,strong)WXStatusOriginalView *originalView;
@property (nonatomic,strong)WXStatusApprovingView *approvingView;
@property (nonatomic,strong)WXStatusCommentView *commentView;

@property (nonatomic,strong)UIView *bottomLine;

@end

@implementation WXStatusDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) { // 初始化子控件
        self.userInteractionEnabled = YES;

        // 1.添加原创或者转发
        WXStatusOriginalView *originalView = [[WXStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        //2. 添加 "赞" 的View
        WXStatusApprovingView *approvingView = [[WXStatusApprovingView alloc] init];
        [self addSubview:approvingView];
        self.approvingView = approvingView;
        
        // 3. 添加 评论的View
        WXStatusCommentView *commentView = [[WXStatusCommentView alloc] init];
        [self addSubview:commentView];
        self.commentView = commentView;
        
        // 4. 添加自定义的 下划线View
        UIView *bottomLine = [[UIView alloc] init];
        [self addSubview:bottomLine];
        bottomLine.backgroundColor = ColorWithA(117, 117, 117,0.4);
        self.bottomLine = bottomLine;
        
    }
    
    return self;
}

- (void)setDetailFrame:(WXStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    
    self.frame = detailFrame.frame;
    
    // 1.原创微信的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    // 2. 赞 的frame数据
    self.approvingView.approvFrame = detailFrame.approvingFrame;

    // 3. 评论的frame数据
    self.commentView.commentFrame = detailFrame.commentFrame;
    
    // 4. 自定义line的数据
    self.bottomLine.frame = detailFrame.bottomLineFrame;
    
}






@end
