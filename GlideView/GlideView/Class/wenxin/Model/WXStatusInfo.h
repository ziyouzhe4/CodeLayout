//
//  StatusInfo.h
//  GlideView
//
//  Created by majianjie on 15/12/15.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WXUserInfo;

@interface WXStatusInfo : NSObject


/** 	string 	状态创建时间*/
@property (nonatomic, copy) NSString *created_at;

/** 	string 	状态信息内容*/
@property (nonatomic, copy) NSString *text;

/** 	string 	状态来源*/
@property (nonatomic, copy) NSString *source;

/** 	object 	状态作者的用户信息字段 详细*/
@property (nonatomic, strong) WXUserInfo *user;

/** 	nsarray 	赞的个数*/
@property (nonatomic, strong) NSMutableString *approving_count;

/** 	 nsarray 	评论数*/
@property (nonatomic, strong) NSArray *comments_count;

/** 	 object 	状态配图地址。多图时返回多图链接。无配图返回“[]”  数组里面都是HMPhoto模型*/
@property (nonatomic, strong) NSArray *pic_urls;


@end
