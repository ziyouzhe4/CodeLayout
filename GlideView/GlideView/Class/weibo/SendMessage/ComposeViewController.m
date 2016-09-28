//
//  ViewController.m
//  ReactiveCocoa
//
//  Created by majianjie on 15/8/4.
//  Copyright (c) 2015年 majianjie. All rights reserved.
//

#import "ComposeViewController.h"
#import "HMTextView.h"
#import "HMComposeToolbar.h"
#import "UIView+Extension.h"
#import "MJJComposePhotosView.h"

@interface ComposeViewController ()<HMComposeToolbarDelegate,UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong) HMTextView *textView;
@property(nonatomic,strong) HMComposeToolbar *toolbar;
@property (nonatomic,weak) MJJComposePhotosView *photosView;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    // 设置导航条内容
    [self setupNavBar];
    

    
    [self setUpTextview];/**<设置输入框*/
    
    [self setUPTooBar];/**< 添加工具条*/
    
    [self addListen];/**<监听键盘的监听*/
    
    [self setUpPhotosView];/**<添加显示照片的相册控件*/
    
}

// 设置导航条内容
- (void)setupNavBar
{
    self.title = @"发微博";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleBordered target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"发送成功");
}

- (void)setUpTextview
{
    HMTextView *textView = [[HMTextView alloc] init];
    self.textView = textView;
    textView.delegate = self;
    textView.alwaysBounceVertical = YES; // 垂直方向上拥有有弹簧效果
    textView.frame =  CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 20, self.view.bounds.size.width, self.view.bounds.size.height);//self.view.bounds;
    textView.placehoder =@"分享新鲜事...";
    [self.view addSubview:textView];

}

- (void)setUPTooBar
{
    // 1.创建
    self.toolbar = [[HMComposeToolbar alloc] init];
    self.toolbar.width = self.view.width;
    self.toolbar.delegate = self;
    self.toolbar.height = 44;
    //    textView.inputAccessoryView = self.toolbar;

    //显示(一开始放在最下面)
    self.toolbar.y = self.view.height - self.toolbar.height;
    [self.view addSubview:self.toolbar];

    
}

- (void)addListen
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)setUpPhotosView
{
    MJJComposePhotosView *photosView =[[MJJComposePhotosView alloc] init];
    self.photosView = photosView;
    self.photosView.width = self.textView.width;
    self.photosView.height = self.textView.height;
    self.photosView.y = 100;
    [self.textView addSubview:photosView];
    
}

- (void)keyBoardWillShow:(NSNotification *)note
{
    //回去键盘弹出的时间
    CGFloat druation = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:druation animations:^{
       
        //取出键盘的高度
        CGRect keyBoradeRect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyBoardH = keyBoradeRect.size.height;
        self.toolbar.transform = CGAffineTransformMakeTranslation(0, - keyBoardH);
        
    }];
    
}

- (void)keyBoardWillHide:(NSNotification *)note
{
    //回去键盘弹出的时间
    CGFloat druation = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:druation animations:^{
        self.toolbar.transform = CGAffineTransformIdentity;/**<CGAffineTransformIdentity属性能还原到 进行动画 之前的状态*/
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.textView becomeFirstResponder];
}

/**
 *  当textView的文字改变就会调用
 */
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.text.length != 0;
}

#pragma mark - UITextViewDelegate
/**
 *  当用户开始拖拽scrollView时调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - HMComposeToolbarDelegate
/**
 *  监听toolbar内部按钮的点击
 */
- (void)composeTool:(HMComposeToolbar *)toolbar didClickedButton:(HMComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case HMComposeToolbarButtonTypeCamera: // 照相机
            NSLog(@"打开照相机");
            [self openCamera];
            break;
            
        case HMComposeToolbarButtonTypePicture: // 相册
            NSLog(@"打开相册");
            [self openAlbum];
            break;
            
        case HMComposeToolbarButtonTypeEmotion: // 表情
            NSLog(@"打开表情");
            [self openEmotion];
            break;
            
        default:
            break;
    }
}

/**<打开相机*/
- (void)openCamera
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        NSLog(@"相机不可用!");
        return;
    }

    UIImagePickerController *pciker =[[UIImagePickerController alloc] init];
    
    pciker.sourceType = UIImagePickerControllerSourceTypeCamera;
    pciker.delegate = self;
    [self presentViewController:pciker animated:YES completion:nil];
    
}

/**<打开相册*/
- (void)openAlbum
{
    UIImagePickerController *pciker =[[UIImagePickerController alloc] init];
    pciker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pciker.delegate = self;
    [self presentViewController:pciker animated:YES completion:nil];
    
}
/**<打开表情*/
- (void)openEmotion
{

}

#pragma mark UIImagePickerControllerDelegate
/**<在相册中选中了图片时候执行的方法*/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];

    NSLog(@"%@",info);
    /**<在info中取出*/
    UIImage *image= info[UIImagePickerControllerOriginalImage];
    /**<添加到 TextView中*/
    [self.photosView addImage:image];
    
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end

