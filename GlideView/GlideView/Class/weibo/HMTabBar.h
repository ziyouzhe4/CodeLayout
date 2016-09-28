//
//  HMTabBar.h
//  majianjie
//
//  Created by apple on 14-7-7.
//  Copyright (c) 2015年 majianjie. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMTabBar;

@protocol HMTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(HMTabBar *)tabBar;

@end

@interface HMTabBar : UITabBar
@property (nonatomic, weak) id<HMTabBarDelegate> tabBarDelegate;
@end
