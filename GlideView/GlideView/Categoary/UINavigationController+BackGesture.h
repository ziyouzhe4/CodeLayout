//
//  UINavigationController+BackGesture.h
//  ddtc
//
//  Created by 赵祥凯 on 15/11/6.
//  Copyright © 2015年 Careerdream. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BackGestureOffsetXToBack 80//>80 show pre vc

@interface UINavigationController (BackGesture)<UIGestureRecognizerDelegate>
/*!
 *	@brief	Default is NO;
 *  @note need call this after ViewDidLoad otherwise not work;
 */
@property (assign,nonatomic) BOOL enableBackGesture;
@end
