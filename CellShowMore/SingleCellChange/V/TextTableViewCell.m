//
//  TextTableViewCell.m
//  CellShowMore
//
//  Created by 王昱斌 on 16/10/25.
//  Copyright © 2016年 bingo. All rights reserved.
//

#import "TextTableViewCell.h"

@implementation TextTableViewCell{
    UIImageView *_titleImage;
    UILabel *_titleLabel;
    UIButton *_moreButton;
    UILabel *_detailLabel;
    UIButton *_actionButton;
    //保存cell的位置信息
    NSIndexPath *_theIndexPath;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
    }
    return self;
}
-(void)createView{
    UIView *back = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, WIDTH, 24))];
    back.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.contentView addSubview:back];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:(CGRectMake(20, 0, 50, 24))];
    titleLabel.textColor = [UIColor blueColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel = titleLabel;
    [back addSubview:_titleLabel];
    
    UIButton *moreButton = [[UIButton alloc]initWithFrame:(CGRectMake(WIDTH - 24, 5, 14, 14))];
    [moreButton setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
    [moreButton setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateSelected)];
    _moreButton = moreButton;
    [back addSubview:_moreButton];
    
    UIButton *actionButton = [[UIButton alloc]initWithFrame:(CGRectMake(0, 0, WIDTH, 24))];
    [actionButton addTarget:self action:@selector(moreButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    _actionButton = actionButton;
    [back addSubview:_actionButton];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:(CGRectMake(20, 8.5, WIDTH, 15))];
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.textAlignment = NSTextAlignmentLeft;
    detailLabel.font = [UIFont systemFontOfSize:12];
    _detailLabel = detailLabel;
    [self addSubview:_detailLabel];
    [self layout];
}

//label的autolayout，使用的国内大神的库SDAutoLayout，也可以使用masonry
-(void)layout{
    [self.contentView sd_addSubviews:@[_detailLabel]];
    _detailLabel.sd_layout
    .topSpaceToView(self.contentView,32)
    .bottomSpaceToView(self.contentView,7)
    .leftSpaceToView(self.contentView,20)
    .rightSpaceToView(self.contentView,10)
    .widthIs(WIDTH - 30);
    [self.contentView updateLayout];
}

- (void)setCellContent:(NSString *)contentStr andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath{
    _detailLabel.text = contentStr;
    _theIndexPath = indexPath;
    //根据需求添加无数据时候的显示逻辑
    if ([contentStr isEqualToString:@""]) {
        _detailLabel.text = @"暂无文字";
    }
    CGSize size = [contentStr boundingRectWithSize:CGSizeMake(WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    //最小的label高度是15
    if (size.height > 15) {
        _moreButton.hidden = NO;
        _actionButton.hidden = NO;
        if (isShow) {
            _detailLabel.numberOfLines = 0;
        }
        else{
            _detailLabel.numberOfLines = 1;
        }
        _moreButton.selected = isShow;
        
    }else{
        _detailLabel.numberOfLines = 1;
        _moreButton.hidden = YES;
        _actionButton.hidden = YES;
    }
    
    [self updateLayout];
}

//按钮点击方法
-(void)moreButtonClick{
    _moreButton.selected = !_moreButton.selected;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:_theIndexPath.row] forKey:@"row"];
    [dic setObject:[NSNumber numberWithBool:_moreButton.selected] forKey:@"isShow"];
    [self.delegate remarksCellShowContrntWithDic:dic andCellIndexPath:_theIndexPath];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
