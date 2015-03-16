//
//  UIImage+captureView.m
//  画画板
//
//  Created by piglikeyoung on 15/3/15.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "UIImage+captureView.h"

@implementation UIImage (captureView)

+(UIImage *)captureImageWithView:(UIView *)view
{
    // 1.创建bitmap上下文
    UIGraphicsBeginImageContext(view.frame.size);
    
    // 2.将要保存的view的layer绘制到bitmap上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出绘制好的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return newImage;
    
}

@end
