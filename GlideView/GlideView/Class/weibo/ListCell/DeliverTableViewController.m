//
//  DeliverTableViewController.m
//  ddtc
//
//  Created by he on 15/11/6.
//  Copyright © 2015年 丁丁停车. All rights reserved.
//

#import "DeliverTableViewController.h"
#import "SearchCell.h"
#import "ODRefreshControl.h"
#import "HMStatusCell.h"
#import "HMStatus.h"
#import "HMStatusFrame.h"
#import "HMHomeStatusesResult.h"
#import "MJExtension.h"
#import "HMPhoto.h"
#import "HMUser.h"
#import "HTTPTool.h"
#import "HMStatusPhotosView.h"
#import "HMStatusPhotoView.h"


@interface DeliverTableViewController ()
{/**下拉刷新控件*/
    ODRefreshControl *mRefreshControl;
    
}
@property (nonatomic,strong)NSMutableArray * statusArr;
/**
 *  微博数组(存放着所有的微博frame数据)
*/
@property (nonatomic, strong) NSMutableArray *statusFrames;

@end

@implementation DeliverTableViewController
static NSString * ID = @"cell";
//header重用ID
static NSString * headerID = @"headerID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"getSigtemClass" forKey:@"action"];
    NSLog(@"%@",dic);
    [HTTPTool GET:@"http://appapi.yaolemo.com/index.php/App/AppSigtem" params:dic success:^(id responseObject, NSURLSessionDataTask *task) {
        NSLog(@"dddd");
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSLog(@"%@",error);
    }];

    [HTTPTool GET:@"http://wechat.jddoctor.cn/weixin/getQrcode.php?id=123456" params:nil success:^(id responseObject, NSURLSessionDataTask *task) {
        
        NSLog(@"ddd");
        
    } failure:^(NSError *error, NSURLSessionDataTask *task) {
        NSLog(@"dddddd");
        
    }];
    
    mRefreshControl = [[ODRefreshControl alloc] initInScrollView:self.tableView];
    [mRefreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];

    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self loadMoreData];
}


- (void)loadMoreData
{
    [HMHomeStatusesResult setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"statuses" : @"HMStatus",
                 // @"statuses" : [Status class],
                 @"user" : @"HMUser",

                 };
    }];
    
//    [HMStatusPhotosView setupObjectClassInArray:^NSDictionary *{
//        return @{
//                 @"pic_urls" : @"HMPhoto",
//                 };
//    }];
    
    [HMStatus setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"pic_urls" : @"HMPhoto",
                 };
    }];
    HMHomeStatusesResult *result = [HMHomeStatusesResult objectWithKeyValues:[self getStatusFromPlistFile]];
    
    //在这里获取文件中的微博数据
    self.statusFrames = [self statusFramesWithStatuses:result.statuses];
    
    [self.statusFrames addObjectsFromArray:self.statusFrames];
    
    [self.tableView reloadData];

}

- (NSDictionary *)getStatusFromPlistFile
{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"wbstatus" ofType:@"plist"];
    NSDictionary *dicInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];

    return dicInfo;
    
}

//刷新的方法
-(void)dropViewDidBeginRefreshing:(ODRefreshControl*)refresh
{
    
    [self loadMoreData];
    
    // 重新刷新表格
    [self.tableView reloadData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
   {
       [mRefreshControl endRefreshing];
   });
}

/**
 *  根据微博模型数组 转成 微博frame模型数据
 *  @param statuses 微博模型数组
 */
- (NSMutableArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (HMStatus *status in statuses) {
        HMStatusFrame *frame = [[HMStatusFrame alloc] init];
        // 传递微博模型数据，计算所有子控件的frame
        frame.status = status;
        [frames addObject:frame];
    }
    return frames;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

#pragma mark - tableView的代理方法和数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HMStatusCell *cell = [HMStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UITableViewHeaderFooterView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerID];
    view.contentView.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - 懒加载
- (NSMutableArray *)statusArr
{
    if (_statusArr == nil) {
        _statusArr = [NSMutableArray array];
    }
    return _statusArr;
}

@end
