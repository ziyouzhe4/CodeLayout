//
//  HMStatusCell.h
//  微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2015年 ma. All rights reserved.
//  微博cell

#import <UIKit/UIKit.h>
@class HMStatusFrame;

@interface HMStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) HMStatusFrame *statusFrame;
@end
