//
//  NSString+Category.h
//  ddtc
//
//  Created by 赵祥凯 on 15/11/6.
//  Copyright © 2015年 Careerdream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Category)

- (CGSize)sizewithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;

- (NSString *)trimming;

- (NSString *)returnTimeStr;

- (BOOL)isEmail;

- (BOOL)isEmpty;

- (BOOL)textCheckWithErrorInfo:(NSString *)errorInfo;
@end
