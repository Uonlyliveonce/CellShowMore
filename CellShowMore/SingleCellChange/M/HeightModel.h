//
//  HeightModel.h
//  CellShowMore
//
//  Created by 王昱斌 on 16/10/25.
//  Copyright © 2016年 bingo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeightModel : NSObject

//传入字符串，是否全部显示，label的宽度，label字号，默认label的高度，除label以外的固定高度，返回cell的高度
+ (CGFloat)cellHeightWith:(NSString *)contentStr andIsShow:(BOOL)isShow andLableWidth:(CGFloat)width andFont:(CGFloat)font andDefaultHeight:(CGFloat)defaultHeight andFixedHeight:(CGFloat)fixedHeight;

@end
