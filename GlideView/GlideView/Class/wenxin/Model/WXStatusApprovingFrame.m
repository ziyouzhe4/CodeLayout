//
//  WXStatusApprovingFrame.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusApprovingFrame.h"
#import "WXStatusInfo.h"

@implementation WXStatusApprovingFrame

- (void)setStatus:(WXStatusInfo *)status
{
    _status = status;
    
    /** 赞的内容 */
    
    CGFloat textX = 0;
    CGFloat textY = 0;
    CGFloat maxW = HMScreenW - 80;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    
    NSMutableString *appStr = [[NSMutableString alloc] init];
    NSString *s = @"❤️";
    [appStr appendString:s];
    [appStr appendString:status.approving_count];
    
    CGSize textSize = [appStr sizeWithFont:WXStatusApprovTextFont constrainedToSize:maxSize];
//    CGSize maxSiz = CGSizeMake(maxSize.width, MAXFLOAT);
//    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont fontWithName:@"" size:14];

//    CGSize textSize = [appStr boundingRectWithSize:maxSiz options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    
    self.approvLabelFrame = CGRectMake(textX, textY, HMScreenW - 80, textSize.height);
        
    /**自己的frame*/
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = HMScreenW - 4 * HMStatusCellInset;
    
    self.frame = CGRectMake(x, y, w, CGRectGetMaxY(self.approvLabelFrame));
    

    
}

@end
