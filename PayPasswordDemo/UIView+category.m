//
//  UIView+category.m
//  PayPasswordDemo
//
//  Created by 高磊 on 2017/1/23.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "UIView+category.h"

@implementation UIView (category)

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
    /*****注释:锯齿*****/
    self.layer.allowsEdgeAntialiasing = YES;
}

- (void)setCornerRadius:(CGFloat)radius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

@end
