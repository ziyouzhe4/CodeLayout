//
//  NSMutableDictionary+Category.h
//  ddtc
//
//  Created by 赵祥凯 on 15/11/5.
//  Copyright © 2015年 Careerdream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Category)

- (void)setObjectSafe:(id)anObject forKey:(id<NSCopying>)aKey;

@end
