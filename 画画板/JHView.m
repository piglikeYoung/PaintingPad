//
//  JHView.m
//  画画板
//
//  Created by piglikeyoung on 15/3/15.
//  Copyright (c) 2015年 jinheng. All rights reserved.
//

#import "JHView.h"

@interface JHView()

/**
 *  定义一个大数组(大数组中保存小数组, 每一个小数组保存一条直线所有的点)
 */
@property (strong , nonatomic) NSMutableArray *totalPoints;

@end

@implementation JHView

-(NSMutableArray *)totalPoints
{
    if (_totalPoints == nil) {
        _totalPoints = [NSMutableArray array];
    }
    
    return _totalPoints;
}

// 开始触摸
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint startPoint = [touch locationInView:touch.view];
    
    // 3.将手指触摸的起点存储到数组中
    // [self.points addObject:[NSValue valueWithCGPoint:startPoint]];
    
    // 3.创建一个小数组，用于保存当前路径所有的点
    NSMutableArray *subPoints = [NSMutableArray array];
    // 4.将手指触摸的起点存储到小数组
    [subPoints addObject:[NSValue valueWithCGPoint:startPoint]];
    // 5.将小数组存储到大数组
    [self.totalPoints addObject:subPoints];

}

// 移动
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint movePoint = [touch locationInView:touch.view];
    // 3.从大数组中取出当前路径对应的小数组
    NSMutableArray *subPoints = [self.totalPoints lastObject];
    // 4.将手指移动时触摸的点存储到小数组
    [subPoints addObject:[NSValue valueWithCGPoint:movePoint]];
    
    // 5.调用drawRect方法重回视图
    [self setNeedsDisplay];
}

// 离开view(停止触摸)
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 1.获取手指对应UITouch对象
    UITouch *touch = [touches anyObject];
    // 2.通过UITouch对象获取手指触摸的位置
    CGPoint endPoint = [touch locationInView:touch.view];
    // 3.从大数组中取出当前路径对应的小数组
    NSMutableArray *subPoints = [self.totalPoints lastObject];
    // 4.将手指移动时触摸的点存储到小数组
    [subPoints addObject:[NSValue valueWithCGPoint:endPoint]];
    
    // 5.调用drawRect方法重回视图
    [self setNeedsDisplay];
}

// 画线
-(void) drawRect:(CGRect)rect
{
    // 1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 遍历大数组，取出小数组中的所有点
    for (NSMutableArray *subPonitArray in self.totalPoints) {
        // 遍历小数组，取出小数组中所有的点
        for (int index = 0; index < subPonitArray.count; index++) {
            // 1.取出小数组中的每一个点
            CGPoint point = [subPonitArray[index] CGPointValue];
            // 2.绘制线段
            if (0 == index) {
                // 2.1 设置线段的起点
                CGContextMoveToPoint(ctx, point.x, point.y);
            } else {
                // 2.2 设置线段的终点
                CGContextAddLineToPoint(ctx, point.x, point.y);
            }
        }
    }
    
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextSetLineWidth(ctx, 10);
    
    // 3.渲染
    CGContextStrokePath(ctx);
}

-(void)clearView
{
    [self.totalPoints removeAllObjects];
    [self setNeedsDisplay];
}

-(void)backView
{
    [self.totalPoints removeLastObject];
    [self setNeedsDisplay];
}

@end
