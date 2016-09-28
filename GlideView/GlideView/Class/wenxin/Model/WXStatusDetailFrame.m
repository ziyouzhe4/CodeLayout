//
//  WXStatusDetailFrame.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusDetailFrame.h"
#import "WXStatusOriginalFrame.h"
#import "WXStatusCommentFrame.h"
#import "WXStatusApprovingFrame.h"
#import "WXStatusInfo.h"

@implementation WXStatusDetailFrame

- (void)setStatus:(WXStatusInfo *)status
{

    _status = status;
    
    // 1.计算原创微信的frame
    WXStatusOriginalFrame *originalFrame = [[WXStatusOriginalFrame alloc] init];
    originalFrame.status = status;
    self.originalFrame = originalFrame;
    
    CGFloat h = 0;

    if (status.approving_count.length > 0) {//(有点赞的计算点赞的frame)
        
        // 2. 计算 点赞 的frame
        WXStatusApprovingFrame *approvingFrame = [[WXStatusApprovingFrame alloc] init];
        approvingFrame.status = status;
        
        //计算原创信息的frame
        CGRect f = approvingFrame.frame;
        f.origin.y = CGRectGetMaxY(originalFrame.frame);
        approvingFrame.frame = f;
        
        self.approvingFrame = approvingFrame;
        
        h = CGRectGetMaxY(approvingFrame.frame);

    }else {
        h = CGRectGetMaxY(originalFrame.frame);
    }
    
    if(status.comments_count){//(有评论的计算评论的frame)
    
        // 3. 计算 评论的frame
        WXStatusCommentFrame *commentFrame = [[WXStatusCommentFrame alloc] init];
        commentFrame.status = status;
        self.commentFrame = commentFrame;
        
        CGRect f = commentFrame.frame;
        f.origin.y = f.origin.y;
        commentFrame.frame = f;
        h = CGRectGetMaxY(commentFrame.frame) + h;
        
    }else{
        h = CGRectGetMaxY(originalFrame.frame) + h;
    }
    
    
    self.bottomLineFrame = CGRectMake(16, h + HMStatusCellInset, HMScreenW - 20, 1);
    
   
//     自己的frame
    CGFloat x = 0;
    CGFloat y = HMStatusCellMargin;
    CGFloat w = HMScreenW;
    self.frame = CGRectMake(x, y, w, h + 2);
    
}


@end
