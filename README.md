# CellShowMore
###因为项目的需要，在单个tableViewCell中需要对过多的文字进行展开收起的动作

####1.首先创建一个Model类来返回行高
```
/*
 *str:传入字符串
 *isShow:是否全部显示
 *width:label的宽度
 *font:label字号
 *defaultHeight:默认label的高度
 *fixedHeight:除label以外的固定高度
 *返回cell的高度
*/
+ (CGFloat)cellHeightWith:(NSString *)str andIsShow:(BOOL)isShow andLableWidth:(CGFloat)width andFont:(CGFloat)font andDefaultHeight:(CGFloat)defaultHeight andFixedHeight:(CGFloat)fixedHeight{
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
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
```

####2.在Controller中写一个可变字典保存展开状态
```
//保存cell的展开状态
@property(nonatomic,strong)NSMutableDictionary *showDictionary;
```

####3.在tableView返回行高的代理方法中根据展开状态字典返回对应行高
```
#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [HeightModel cellHeightWith:self.dataArray[indexPath.row] andIsShow:[[self.showDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue] andLableWidth:WIDTH - 30 andFont:12 andDefaultHeight:15 andFixedHeight:39];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTextTableViewCell"];
    if (!cell) {
        cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DetailTextTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    //cell展开按钮点击触发的block
    cell.moreBlock = ^(NSDictionary *dic,NSIndexPath *indexPath){
        [self.showDictionary setObject:[dic objectForKey:@"isShow"] forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"row"]]];
        [self.rootTableView reloadData];
    };
    [cell setCellContent:[self.dataArray objectAtIndex:indexPath.row] andIsShow:[[self.showDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue]  andCellIndexPath:indexPath];
    return cell;

}

```

####4.设置属性，点击展开按钮block
```
//点击按钮的block
@property(nonatomic,copy)void (^moreBlock)(NSDictionary *dic,NSIndexPath *indexPath);
```
####5.设置AutoLayout
```
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
```
####6.cell的赋值方法
```
//cell的赋值方法，传入字符串，是否全部显示，tanleView的位置信息
- (void)setCellContent:(NSString *)str andIsShow:(BOOL)isShow andCellIndexPath:(NSIndexPath *)indexPath{
    _detailLabel.text = str;
    _theIndexPath = indexPath;
    //根据需求添加无数据时候的显示逻辑
    if ([str isEqualToString:@""]) {
        _detailLabel.text = @"暂无文字";
    }
    CGSize size = [str boundingRectWithSize:CGSizeMake(WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
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
```

####7.按钮的点击方法
```
//按钮点击方法
-(void)moreButtonClick{
    _moreButton.selected = !_moreButton.selected;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NSNumber numberWithInteger:_theIndexPath.row] forKey:@"row"];
    [dic setObject:[NSNumber numberWithBool:_moreButton.selected] forKey:@"isShow"];
    self.moreBlock(dic,_theIndexPath);
}
```

代码仅供参考，希望可以帮到你，如果你有更好的方法还希望能互相学习互相进步！

<a href="http://www.jianshu.com/p/aa65d274f7ab">简书地址</a>

<a href="https://github.com/gsdios/SDAutoLayout">SDAutoLayout下载地址</a>
