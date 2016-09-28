//
//  ZZCommon.h
//  ddtc
//
//  Created by he on 15/11/6.
//  Copyright © 2015年 丁丁停车. All rights reserved.
//

#ifndef ZZCommon_h
#define ZZCommon_h

#define WEAKSELF __weak typeof(self) weakSelf = self;

//=====================尺寸,设备型号,机型=====================
//全屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//全屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

//通过尺寸判断机型
#define iPhone4 ScreenSize(640,960)
#define iPhone5 ScreenSize(640,1136)
#define iPhone6 ScreenSize(750,1334)
#define iPhone6Plus ScreenSize(1242,2208)

#define ScreenSize(width,height) \
([UIScreen instancesRespondToSelector:@selector(currentMode)]                \
? CGSizeEqualToSize(CGSizeMake(width, height),                             \
[[UIScreen mainScreen] currentMode].size)           \
: NO)

//设备型号识别
#define is_iOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define is_iOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define is_iOS_9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define down_iOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

//=====================系统配置=====================
//路径
#define DocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]
#define CachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//NSUserDefault
#define DEFAULTS [NSUserDefaults standardUserDefaults]
//通知中心
#define NotificationCenter [NSNotificationCenter defaultCenter]

//=====================颜色=====================
//主题色
#define Theme_Color @"#223957"
//白色
#define White [UIColor whiteColor]
//浅灰色
#define LightGrayColor [UIColor lightGrayColor]
//深灰色
#define GrayColor [UIColor grayColor]
//橘黄色
#define OrangeColor [UIColor orangeColor]
//黑色
#define BlackColor [UIColor blackColor]



// 颜色
#define Color(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define RandomColor MJColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
//设置layer颜色
#define LayerColor(r, g, b , a) [[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a] CGColor]
//带透明度的颜色
#define ColorWithA(r, g, b , a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]



//=====================字体=====================
//大
#define Big_Font SetFont(18)
//中
#define Mid_Font SetFont(16)
//小
#define Small_Font SetFont(14)
//微
#define Micro_Font SetFont(10)

//设置颜色
#define HexColor(color) [UIColor hexStringToColor:color]
//设置字体
#define SetFont(Num) [UIFont systemFontOfSize:Num]
//占位图
#define Placeholder_Image [UIImage imageNamed:@"zhiwei_logo_bg"]

//上传图片质量
#define Img_Quality 0.1


#endif 
/* ZZCommon_h */
