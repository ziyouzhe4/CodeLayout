//
//  HMPhotoView.m
//  GlideView
//
//  Created by majianjie on 15/12/10.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "HMStatusPhotoView.h"
#import <UIImageView+WebCache.h>
#import "HMPhoto.h"

@interface HMStatusPhotoView()

@property (nonatomic, weak) UIImageView *gifView;


@end

@implementation HMStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {

        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageWithName:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
        
        
    }
    return self;
}

- (void)setPhoto:(HMPhoto *)photo
{
    _photo =photo;

    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"tab_icon_wo_hl"] completed:nil];
    
    
    // 2.控制gif图标的显示
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifView.hidden = ![extension isEqualToString:@"gif"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}


@end
