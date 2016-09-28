//
//  SearchCell.h
//  ddtc
//
//  Created by he on 15/11/6.
//  Copyright © 2015年 丁丁停车. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Deliver;

@interface SearchCell : UITableViewCell

@property (nonatomic,strong)Deliver * deliver;

@property (weak, nonatomic) IBOutlet UIImageView *imageV;


@end
