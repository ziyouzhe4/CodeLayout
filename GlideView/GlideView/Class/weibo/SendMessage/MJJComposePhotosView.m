//
//  MJJComposePhotosView.m
//  ReactiveCocoa
//
//  Created by majianjie on 15/8/12.
//  Copyright (c) 2015年 majianjie. All rights reserved.
//

#import "MJJComposePhotosView.h"
#import "UIView+Extension.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"

@interface MJJComposePhotosView()


@end

@implementation MJJComposePhotosView

- (void)addImage:(UIImage *)image
{
    
    UIImageView *imageView =[[UIImageView alloc] init];
    imageView.image = image;
    imageView.tag = self.subviews.count;

    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    imageView.userInteractionEnabled = YES;
    //为每个照片添加点击事件
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
    [recognizer addTarget:self action:@selector(tapPhoto:)];
    [imageView addGestureRecognizer:recognizer];
    
    //为每个照片添加长安手势
    UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] init];
    [longRecognizer addTarget:self action:@selector(longPress:)];
    [imageView addGestureRecognizer:longRecognizer];
    
}

/**
 *  监听图片的点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    [self endEditing:YES];
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示的所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.subviews.count;
    for (int i = 0; i<count; i++) {
        
        MJPhoto *photo = [[MJPhoto alloc] init];
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

- (void)longPress:(UILongPressGestureRecognizer *)recognizer
{
    UIImageView *imageView = (UIImageView *)recognizer.view;
    
    //让View做颤抖动画
    [self makeAnimationWith:imageView];
    NSLog(@"%ld",(long)imageView.tag);
    UIButton *closeBtn = [[UIButton alloc] init];

    [closeBtn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    
    [closeBtn addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.frame = CGRectMake(CGRectGetMaxX(imageView.frame) - 30, 0, 20, 20);
    [imageView addSubview:closeBtn];

}

- (void)makeAnimationWith:(UIImageView *)imageView
{
    CGFloat t =1.0;
    
    CGAffineTransform leftQuake  =CGAffineTransformTranslate(CGAffineTransformIdentity, t,-t);
    CGAffineTransform rightQuake =CGAffineTransformTranslate(CGAffineTransformIdentity,-t, t);
    
    imageView.transform = leftQuake;  // starting point
    
    [UIView beginAnimations:@"earthquake" context:(__bridge void * _Nullable)(imageView)];
    [UIView setAnimationRepeatAutoreverses:YES];// important
    [UIView setAnimationRepeatCount:1000000];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(earthquakeEnded:finished:context:)];
    
    imageView.transform = rightQuake;// end here & auto-reverse
    
    [UIView commitAnimations];
}

-(void)earthquakeEnded:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
{
    if([finished boolValue])
    {
        UIView* item =(__bridge UIView*)context;
        item.transform =CGAffineTransformIdentity;
    }
}




- (void)delete:(UIButton *)btn
{
    [btn.superview removeFromSuperview];

}


- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    int maxCloumsPerRow = 4;  /**<一行最多4张*/
    CGFloat margin = 10;//每个图片间间距
    
    CGFloat width = (self.width - (maxCloumsPerRow + 1) * margin )/maxCloumsPerRow; //每个图像的宽高
    CGFloat height =width;
    
    for (int i=0; i<[self.subviews count]; i++) {
        
        int row = i / maxCloumsPerRow;//行号
        int col = i % maxCloumsPerRow; //列号
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = width;
        imageView.height = height;
        imageView.x = col * (width + margin) + margin;
        imageView.y = row * (height + margin);
        
        /**<最多放5张图片*/
        if(self.subviews.count >10){
            [self.subviews[10] removeFromSuperview];
        }
        
    }
 

}

@end
