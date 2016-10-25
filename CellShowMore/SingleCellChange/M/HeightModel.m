//
//  HeightModel.m
//  CellShowMore
//
//  Created by 王昱斌 on 16/10/25.
//  Copyright © 2016年 bingo. All rights reserved.
//
#import "HeightModel.h"

@implementation HeightModel





+ (CGFloat)cellHeightWith:(NSString *)contentStr andIsShow:(BOOL)isShow andLableWidth:(CGFloat)width andFont:(CGFloat)font andDefaultHeight:(CGFloat)defaultHeight andFixedHeight:(CGFloat)fixedHeight{
    
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    if (size.height > defaultHeight) {
        if (isShow) {
            return size.height + fixedHeight;
        }
        else{
            return defaultHeight + fixedHeight;
        }
    }
    else{
        return defaultHeight + fixedHeight;
    }
}

@end
