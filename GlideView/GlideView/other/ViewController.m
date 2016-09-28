//
//  ViewController.m
//  GlideView
//
//  Created by majianjie on 15/12/3.
//  Copyright © 2015年 majianjie. All rights reserved.
//

#import "ViewController.h"
#import "DeliverViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DeliverViewController *deliver = [[DeliverViewController alloc] init];
    
    [self.navigationController pushViewController:deliver animated:YES];
}

@end
