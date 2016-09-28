//
//  UserInfo.h
//  GlideView
//
//  Created by majianjie on 15/12/15.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXUserInfo : NSObject

/**<用户的名字*/
@property (nonatomic,strong) NSString *name;

/**<用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;



@end
