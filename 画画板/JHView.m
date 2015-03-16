//
//  JHView.m
//  画画板
//
//  Created by piglikeyoung on 15/3/15.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHView.h"

@interface JHView()

@property (strong , nonatomic) NSMutableArray *paths;

@end

@implementation JHView

-(NSMutableArray *)paths
{
    if (_paths == nil) {
        _paths = [NSMutableArray array];
    }
    
    return _paths;
}

// 开始触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    
    // 3.当前用户手指按下的时候创建一条路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 3.1设置路径的相关属性
    [path setLineJoinStyle:kCGLineJoinRound];
    [path setLineCapStyle:kCGLineCapRound];
    [path setLineWidth:10];
    
    // 4.设置当前路径的起点
    [path moveToPoint:startPoint];
    // 5.将路径添加到数组中
    [self.paths addObject:path];

}

// 移动
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    
    // 3.取出当前的path
    UIBezierPath *currentPath = [self.paths lastObject];
    // 4.设置当前路径的终点
    [currentPath addLineToPoint:movePoint];
    
    // 5.调用drawRect方法重回视图
    [self setNeedsDisplay];
}

// 离开view(停止触摸)
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

// 画线
-(void) drawRect:(CGRect)rect
{
    [[UIColor redColor] set];
    // 遍历数组绘制所有路径
    for (UIBezierPath *path in self.paths) {
        [path stroke];
    }
    
}

-(void)clearView
{
    [self.paths removeAllObjects];
    [self setNeedsDisplay];
}

-(void)backView
{
    [self.paths removeLastObject];
    [self setNeedsDisplay];
}

@end
