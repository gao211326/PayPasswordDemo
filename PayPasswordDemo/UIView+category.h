//
//  UIView+category.h
//  PayPasswordDemo
//
//  Created by 高磊 on 2017/1/23.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (category)

/**
 设置边框

 @param color 颜色
 @param width 边框宽度
 */
- (void)setBorderColor:(UIColor *)color width:(CGFloat)width;


/**
 设置view的圆角

 @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;

@end
