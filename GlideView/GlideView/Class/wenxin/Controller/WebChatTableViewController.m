//
//  WebChatTableViewController.m
//  ddtc
//
//  Created by majianjie on 15/12/16.
//  Copyright © 2015年 丁丁停车. All rights reserved.
//

#import "WebChatTableViewController.h"
#import "ODRefreshControl.h"
#import "WXStatusCell.h"
#import "WXStatusInfo.h"
#import "WXHomeStatusesResult.h"
#import <MJExtension.h>
#import "WXStatusFrame.h"
#import "WXUserInfo.h"
#import "HMStatusPhotosView.h"
#import "WXStatusInfo.h"
#import <UITableView+SDAutoTableViewCellHeight.h>
#import "WXHeaderView.h"

@interface WebChatTableViewController ()

/**
 *  微博数组(存放着所有的微博frame数据)
*/
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation WebChatTableViewController
static NSString * ID = @"cell";
//header重用ID
static NSString * headerID = @"headerID";

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置头View
    WXHeaderView *headerView = [WXHeaderView new];
    headerView.frame = CGRectMake(0, 0, 0, 260);
    self.tableView.tableHeaderView = headerView;
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self loadMoreData];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [self.view setBackgroundColor:Color(35, 37, 38)];
}

- (void)loadMoreData
{
    [WXHomeStatusesResult setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"WXStatusInfo",
                 @"user" : @"WXUserInfo",
                 };
    }];
    
    [HMStatusPhotosView setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"pic_urls" : @"WXPhoto",
                 };
    }];
    
    [WXStatusInfo setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"pic_urls" : @"WXPhoto",
                 };
    }];
    
    WXHomeStatusesResult *result = [WXHomeStatusesResult objectWithKeyValues:[self getStatusFromPlistFile]];
    
//    在这里获取文件中的微博数据
    self.statusFrames = [self statusFramesWithStatuses:result.statuses];
        
    [self.tableView reloadData];
}

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *  @param statuses 微博模型数组
 */
- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WXStatusInfo *status in statuses) {
        WXStatusFrame *frame = [[WXStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

- (NSDictionary *)getStatusFromPlistFile
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"wxstatus" ofType:@"plist"];
    NSDictionary *dicInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    return dicInfo;
    
}

#pragma mark - tableView的代理方法和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXStatusCell *cell = [WXStatusCell cellWithTableView:tableView];
    cell.statusFrame = self.statusFrames[indexPath.row];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    view.contentView.backgroundColor = [UIColor clearColor];
    return view;
    
//    //隐藏顶部的分割线
//    UIView *headView = [[UIView alloc]init];
//    headView.backgroundColor = [UIColor whiteColor];
//    headView.height = 10;
//    return headView;
//    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNotification * notice = [NSNotification notificationWithName:@"hidepopView" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSNotification * notice = [NSNotification notificationWithName:@"hidepopView" object:nil userInfo:nil];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notice];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WXStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:@"hidepopView" object:nil];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    //隐藏顶部的分割线
//    UIView *headView = [[UIView alloc]init];
//    
//    headView.backgroundColor = [UIColor whiteColor];
//    
//    headView.height = 10;
//    
//    return headView;
//}

@end
