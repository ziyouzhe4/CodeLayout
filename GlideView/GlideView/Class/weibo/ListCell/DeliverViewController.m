//
//  DeliverViewController.m
//  ddtc
//
//  Created by he on 15/11/6.
//  Copyright © 2015年 丁丁停车. All rights reserved.
//

#import "DeliverViewController.h"
#import "DeliverMenu.h"
#import "DeliverTableViewController.h"
#import "ODRefreshControl.h"
#import "WebChatTableViewController.h"

#define Menu_H 35
#define Gap 10

@interface DeliverViewController ()<DeliverMenuDelegate>
{
    /**
     *  @brief  下拉刷新控件
     */
    ODRefreshControl *mRefreshControl;
}
@property (weak, nonatomic) IBOutlet UIView *menuVIew;
@property (nonatomic,strong) DeliverMenu * deliverMenu;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) DeliverTableViewController *allDeliverVC;
@property (strong, nonatomic) WebChatTableViewController *readedDeliverVC;
@property (strong, nonatomic) DeliverTableViewController *interviewDeliverVC;
@property (strong, nonatomic) DeliverTableViewController *noMatchingDeliverVC;
@property  (strong, nonatomic) UIViewController *five;

@end

@implementation DeliverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupControls];
    
    [self setupTableView];
    
    UIScreenEdgePanGestureRecognizer * screen= [self screenEdgePanGestureRecognizer];
    if (screen != nil) {
        [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:[self screenEdgePanGestureRecognizer]];
    }
}

/**
 *  初始化控件
 */
- (void)setupControls
{
    DeliverMenu * deliverMenu = [[DeliverMenu alloc]initWithFrame:self.menuVIew.bounds];
    deliverMenu.delegate = self;
    self.deliverMenu = deliverMenu;
    [self.menuVIew addSubview:deliverMenu];

    [deliverMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(@0);
    }];
}

- (void)setupTableView
{
    //微博
    DeliverTableViewController * allDeliverVC = [[DeliverTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.allDeliverVC = allDeliverVC;
    
    //微信
    WebChatTableViewController *readedDeliverVC = [[WebChatTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.readedDeliverVC = readedDeliverVC;
    
    //面试
    DeliverTableViewController *interviewDeliverVC = [[DeliverTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.interviewDeliverVC = interviewDeliverVC;
    
    //不匹配
    DeliverTableViewController *noMatchingDeliverVC = [[DeliverTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    self.noMatchingDeliverVC = noMatchingDeliverVC;
    
    
    [self addChildViewController:allDeliverVC];
    [self addChildViewController:readedDeliverVC];
    [self addChildViewController:interviewDeliverVC];
    [self addChildViewController:noMatchingDeliverVC];
    
    [self.scrollView addSubview:allDeliverVC.view];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat width = self.scrollView.width;
    CGFloat height = self.scrollView.height;
    
    self.allDeliverVC.view.frame = CGRectMake(Gap, -30, SCREEN_WIDTH, height);
    self.readedDeliverVC.view.frame = CGRectMake(width + Gap, -30, SCREEN_WIDTH, height);
    self.interviewDeliverVC.view.frame = CGRectMake(width * 2 + Gap, -30, SCREEN_WIDTH, height);
    self.noMatchingDeliverVC.view.frame = CGRectMake(width * 3 + Gap, -30, SCREEN_WIDTH, height);
    
    self.scrollView.contentSize = CGSizeMake(width * self.deliverMenu.titleA.count, height);
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    NSLog(@"%f",offsetX);
    if (offsetX >= 0 && offsetX <= SCREEN_WIDTH * self.deliverMenu.titleA.count) {
        [self.deliverMenu setBottomLineCenterX:(offsetX - 20)/ self.deliverMenu.titleA.count + SCREEN_WIDTH / self.deliverMenu.titleA.count / 2];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    int page = offsetX / SCREEN_WIDTH;
    [self changeViewWithIndex:page];
}

- (void)changeMenuViewBottomLineWithPath:(int)page
{
    UIButton * sender = self.deliverMenu.btnArr[page];
    
    [self.deliverMenu btnRefre:sender];
    
    [UIView animateWithDuration:0.2 animations:^{
        [self.deliverMenu setBottomLineCenterX:sender.centerX];
    }];
}

#pragma mark - ZZDeliverMenuViewDelegate
- (void)deliverMenu:(DeliverMenu *)deliverMenu index:(NSInteger)index
{
    self.scrollView.contentOffset = CGPointMake(index * self.scrollView.width, 0);
    
    [self changeViewWithIndex:(int)index];
}

- (void)changeViewWithIndex:(int)page
{
    switch (page) {
        case 0:
        {
            [self changeMenuViewBottomLineWithPath:page];
            
            break;
        }
        case 1:
        {
            [self changeMenuViewBottomLineWithPath:page];
            [self.scrollView addSubview:self.readedDeliverVC.view];
            break;
        }
        case 2:
        {
            [self changeMenuViewBottomLineWithPath:page];
            [self.scrollView addSubview:self.interviewDeliverVC.view];
            break;
        }
        case 3:
        {
            [self changeMenuViewBottomLineWithPath:page];
            [self.scrollView addSubview:self.noMatchingDeliverVC.view];
            break;
        }
        case 4:
        {
            [self changeMenuViewBottomLineWithPath:page];
            [self.scrollView addSubview:self.five.view];
            break;
        }
    }
}

#pragma mark - private methods
- (UIScreenEdgePanGestureRecognizer *)screenEdgePanGestureRecognizer
{
    UIScreenEdgePanGestureRecognizer * screenEdgePanGestureRecognizer = nil;
    if (self.navigationController.view.gestureRecognizers.count > 0) {
        for (UIGestureRecognizer * recognizer in self.navigationController.view.gestureRecognizers) {
            if ([recognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
                screenEdgePanGestureRecognizer = (UIScreenEdgePanGestureRecognizer *)recognizer;
                break;
            }
        }
    }
    return screenEdgePanGestureRecognizer;
}

@end
