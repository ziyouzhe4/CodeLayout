//
//  WXStatusOriginalFrame.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusOriginalFrame.h"
#import "WXStatusInfo.h"
#import "WXUserInfo.h"
#import "WXStatusPhotosView.h"

@implementation WXStatusOriginalFrame


- (void)setStatus:(WXStatusInfo *)status
{
    _status = status;
    
    /** 1头像 */
    CGFloat iconX = HMStatusCellInset;
    CGFloat iconY = HMStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    /** 2昵称 */
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + HMStatusCellInset;
    CGFloat nameY = iconY;
    CGSize nameSize = [status.user.name sizeWithFont:HMStatusOrginalNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    /** 3正文 */
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + HMStatusCellInset;
    CGFloat maxW = HMScreenW - 1.5 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:HMStatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    /** 4配图相册  */
    CGFloat h = 0;
    if (status.pic_urls.count) {//有配图
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
        CGSize size = [WXStatusPhotosView sizeWithPhotosCount:status.pic_urls.count];
        self.photosFrame = CGRectMake(photosX, photosY, size.width ,size.height);
        h = CGRectGetMaxY(self.photosFrame) + HMStatusCellInset;
        
    }else{//没有配图
        h = CGRectGetMaxY(self.textFrame) + HMStatusCellInset;
    }
    
    /** 时间label*/
    CGFloat timeX = CGRectGetMaxX(self.iconFrame) + HMStatusCellInset;
    CGFloat timeY = h;
    CGSize timeSize = [status.created_at sizeWithFont:HMStatusOrginalNameFont];
    self.timeFrame = (CGRect){{timeX, timeY}, timeSize};
    
    
    /** 来源label*/
    CGFloat sourceX = timeX + HMStatusCellInset;
    CGFloat sourceY = h;
    CGSize sourceSize = [status.source sizeWithFont:HMStatusOrginalNameFont];
    self.sourceFrame = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    /** 点赞按钮*/
    CGFloat approvX = SCREEN_WIDTH -  4 * HMStatusCellInset;
    CGFloat approvY = h - 8;
    CGSize appSize = CGSizeMake(20, timeSize.height);
    self.approvFrame = (CGRect){{approvX, approvY - 8}, appSize};
    
    
    /**自己的frame*/
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = HMScreenW;
    
    self.frame = CGRectMake(x, y, w, CGRectGetMaxY(self.timeFrame));
 

}


@end
