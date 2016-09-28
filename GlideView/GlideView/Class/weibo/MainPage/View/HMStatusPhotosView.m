//
//  HMPhotosView.m
//  GlideView
//
//  Created by majianjie on 15/12/10.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "HMStatusPhotosView.h"
#import "HMStatusPhotoView.h"
#import "HMStatusPhotoView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "HMPhoto.h"


@implementation HMStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        //预先开辟9个存储空间,避免每次都申请
        for (int i = 0; i< 9; i++) {
            HMStatusPhotoView *photoView = [[HMStatusPhotoView alloc] init];
            photoView.tag = i;
            photoView.backgroundColor = [UIColor blueColor];
            
            [self addSubview:photoView];

            // 添加手势监听器（一个手势监听器 只能 监听对应的一个view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
            
        }
        
    }
    return self;
}


/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.pic_urls.count;
    for (int i = 0; i<count; i++) {
        HMPhoto *pic = self.pic_urls[i];
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIImageView
        photo.srcImageView = self.subviews[i];
        
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 3.显示浏览器
    [browser show];
}


- (void)setPic_urls:(NSArray *)pic_urls
{
    //调用十分频繁
    _pic_urls = pic_urls;
    
    for(int i=0 ;i < self.subviews.count;i++){
        HMStatusPhotoView *photoView = self.subviews[i];
        if (i<pic_urls.count) {
            photoView.hidden = NO;

            photoView.photo = pic_urls[i];

        }else{
            photoView.hidden = YES;
        }
    }
}

+ (CGSize)sizeWithPhotosCount:(NSInteger)photosCount
{
    CGFloat photoW = 70;
    CGFloat photoH = photoW;
    CGFloat photoMargin = 10;
    int maxCols = 3;
    //一行最多几列
    NSInteger totalCols = photosCount >= maxCols ? maxCols : photosCount;
    
    //  知道总个数 知道每一页显示多少个   能算出能显示多少页
#warning 记住这个计算公式
    NSInteger totalRows = (photosCount + maxCols - 1) / maxCols;
    //               总宽度
    CGFloat photosW = totalCols * photoW + (totalCols - 1) * photoMargin;
    //               总高度
    CGFloat photosH = totalRows * photoH + (totalRows - 1) * photoMargin;
    
    return CGSizeMake(photosW, photosH);

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat photoMargin = 10;
    
    for (int i = 0 ;i < self.subviews.count; i++) {
        
        HMStatusPhotoView *photoView = self.subviews[i];
        
        photoView.width = 70;
        photoView.height = 70;
        
        photoView.x = (i % 3) * (70 + photoMargin);
        photoView.y = (i / 3) * (70 + photoMargin);
    }
}


@end
