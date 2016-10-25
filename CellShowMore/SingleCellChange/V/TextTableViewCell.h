//
//  TextTableViewCell.h
//  CellShowMore
//
//  Created by 王昱斌 on 16/10/25.
//  Copyright © 2016年 bingo. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol TextTableViewCellCellDelegate <NSObject>
//点击按钮时候的代理方法，与block二选一
- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath;

@end

@interface TextTableViewCell : UITableViewCell

@property(nonatomic,weak)id<TextTableViewCellCellDelegate> delegate;

//点击按钮的block
@property(nonatomic,copy)void (^moreBlock)(NSDictionary *dic,NSIndexPath *indexPath);

//cell的刷新方法，传入字符串，是否全部显示，tanleView的位置信息
- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath;


@end
