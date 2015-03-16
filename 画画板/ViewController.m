//
//  ViewController.m
//  画画板
//
//  Created by piglikeyoung on 15/3/15.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "ViewController.h"
#import "JHView.h"
#import "UIImage+captureView.h"
#import "MBProgressHUD+NJ.h"

@interface ViewController ()
/**
    清屏
 
 */
- (IBAction)clearScreen;
/**
 
    回退
 */
- (IBAction)backClick;
/**
    保存
 */
- (IBAction)saveClick;

@property (weak, nonatomic) IBOutlet JHView *customView;

@end

@implementation ViewController


- (IBAction)clearScreen {
    
    [self.customView clearView];
}

- (IBAction)backClick {
    
    [self.customView backView];
}

- (IBAction)saveClick {
    
    UIImage *newImage = [UIImage captureImageWithView:self.customView];
    // 保存到相册
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:@"保存失败"];
    }else
    {
        [MBProgressHUD showSuccess:@"保存成功"];
    }
}
@end
