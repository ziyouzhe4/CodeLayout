//
//  WXStatusApprovingView.m
//  GlideView
//
//  Created by majianjie on 15/12/17.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "WXStatusApprovingView.h"
#import "WXStatusInfo.h"
#import "WXStatusApprovingFrame.h"

@interface WXStatusApprovingView()

@property (nonatomic,strong)NSMutableString *approvText;

@property (nonatomic,strong)UILabel *approvLabel;


@end

@implementation WXStatusApprovingView

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    

    if (self) {
        //显示所有的评论和 "❤️"
        UILabel *approvLabel = [[UILabel alloc] init];
        self.approvLabel = approvLabel;
        self.approvLabel.textColor = ColorWithA(38, 102, 248, 0.6);
        approvLabel.numberOfLines = 0;
        [self addSubview:approvLabel];
        
        self.approvLabel.backgroundColor = ColorWithA(117, 117, 117, 0.1);
        
    }
    
    return self;
}


- (void)setApprovFrame:(WXStatusApprovingFrame *)approvFrame
{
    _approvFrame = approvFrame;
    
    CGRect f = approvFrame.frame;
    f.origin.x = 40;
    f.size.width = HMScreenW - 80;
    self.frame = f;
    
    NSMutableString *appStr = [[NSMutableString alloc] init];
    
    NSString *s = @"❤️";
    [appStr appendString:s];
    [appStr appendString:approvFrame.status.approving_count == nil ? @"" :approvFrame.status.approving_count];
    
    self.approvLabel.text =  appStr;//approvFrame.status.approving_count;
    self.approvLabel.frame = approvFrame.approvLabelFrame;
    
}





@end
