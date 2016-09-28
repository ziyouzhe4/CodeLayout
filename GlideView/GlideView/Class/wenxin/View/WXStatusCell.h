//
//  WXStatusCell.h
//  GlideView
//
//  Created by majianjie on 15/12/16.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXStatusFrame,WXStatusDetailView;


@interface WXStatusCell : UITableViewCell



+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) WXStatusFrame *statusFrame;

@property (nonatomic,strong)WXStatusDetailView *detailView;


@end
