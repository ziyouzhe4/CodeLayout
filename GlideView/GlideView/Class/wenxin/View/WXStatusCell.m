//
//  WXStatusCell.m
//  GlideView
//
//  Created by majianjie on 15/12/16.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusCell.h"
#import "WXStatusDetailView.h"
#import "WXStatusDetailFrame.h"
#import "WXStatusFrame.h"

@interface WXStatusCell()



@end

@implementation WXStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"status";
    WXStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WXStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
//    [cell setBackgroundColor:White];

    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) { // 初始化子控件
        // 1.添加微博具体内容
        WXStatusDetailView *detailView = [[WXStatusDetailView alloc] init];
        [self.contentView addSubview:detailView];
        self.detailView = detailView;
        
        // 3.cell的设置
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setStatusFrame:(WXStatusFrame *)statusFrame
{
    
   _statusFrame = statusFrame;

    // 1.微博具体内容的frame数据
     self.detailView.detailFrame = statusFrame.detailFrame;
    
}


@end
