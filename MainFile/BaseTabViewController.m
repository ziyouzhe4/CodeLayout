//
//  BaseTabViewController.m
//  GlideView
//
//  Created by majianjie on 15/12/3.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "BaseTabViewController.h"
#import "DeliverViewController.h"
#import "HMTabBar.h"
#import "ComposeViewController.h"

@interface BaseTabBarViewController()<UITabBarControllerDelegate,HMTabBarDelegate>

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    
    self.delegate = self;
   
    // 添加所有的子控制器
    [self addAllChildVcs];

    // 创建自定义tabbar
    [self addCustomTabBar];
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    HMTabBar *customTabBar = [[HMTabBar alloc] init];
    customTabBar.tabBarDelegate = self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];

}

-(void)addAllChildVcs{

    //职位
    DeliverViewController * positionVC = [[DeliverViewController alloc]init];
    [self addchildVC:positionVC title:@"测试1" image:@"tab_icon_wo" selectedImage:@"tab_icon_wo_hl"];
    //我的
    UIViewController* mineVC = [[UIViewController alloc]init];
    [mineVC.view setBackgroundColor:[UIColor lightGrayColor]];
    [self addchildVC:mineVC title:@"测试2" image:@"tab_icon_wo" selectedImage:@"tab_icon_wo_hl"];
    //职位
    UIViewController * posi = [[UIViewController alloc]init];
    [posi.view setBackgroundColor:[UIColor orangeColor]];
    [self addchildVC:posi title:@"测试3" image:@"tab_icon_wo" selectedImage:@"tab_icon_wo_hl"];
    //我的
    UIViewController* min = [[UIViewController alloc]init];
    [min.view setBackgroundColor:[UIColor yellowColor]];
    [self addchildVC:min title:@"测试4" image:@"tab_icon_wo" selectedImage:@"tab_icon_wo_hl"];
    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 强制重新布局子控件（内部会调用layouSubviews）
    [self.tabBar setNeedsLayout];
}

/**
 *  添加子控制器
 *
 *  @param childVC       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中图片
 */
- (void)addchildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVC.title = title;
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字样式
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"#597a96"];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary * selecttextAttrs = [NSMutableDictionary dictionary];
    selecttextAttrs[NSForegroundColorAttributeName] = [UIColor hexStringToColor:@"#12aaeb"];
    [childVC.tabBarItem setTitleTextAttributes:selecttextAttrs forState:UIControlStateSelected];
    
    UINavigationController * nac = [[UINavigationController alloc]initWithRootViewController:childVC];
    
    [self addChildViewController:nac];
}

#pragma mark - 自定义tabBar的代理
- (void)tabBarDidClickedPlusButton:(HMTabBar *)tabBar
{
    // 弹出发微博控制器
    ComposeViewController *compose = [[ComposeViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
