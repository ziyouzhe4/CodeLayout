//
//  WXStatusCommentView.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusCommentView.h"

@interface WXStatusCommentView()

@property (nonatomic,strong) UILabel *commentLabel;

@end

@implementation WXStatusCommentView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        
        self.backgroundColor = ColorWithA(117, 117, 117, 0.1);
        
        UILabel *comentLabel = [[UILabel alloc] init];
        [self addSubview:comentLabel];
        self.commentLabel = comentLabel;
    
        
        
    }
    
    return self;
    
}



@end
