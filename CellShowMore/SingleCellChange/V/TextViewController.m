//
//  TextViewController.m
//  CellShowMore
//
//  Created by 王昱斌 on 16/10/25.
//  Copyright © 2016年 bingo. All rights reserved.
//
#import "HeightModel.h"

#import "TextTableViewCell.h"

#import "TextViewController.h"

@interface TextViewController ()<UITableViewDelegate,UITableViewDataSource,TextTableViewCellCellDelegate>


@property(nonatomic,strong)UITableView *rootTableView;
//数据源数组
@property(nonatomic,copy)NSMutableArray *dataArray;
//保存cell的展开状态
@property(nonatomic,strong)NSMutableDictionary *showDictionary;


@end

@implementation TextViewController
-(NSMutableDictionary *)showDictionary{
    if (!_showDictionary) {
        _showDictionary = [NSMutableDictionary dictionary];
    }
    return  _showDictionary;
}
-(UITableView *)rootTableView{
    if (!_rootTableView) {
        _rootTableView = [[UITableView alloc]initWithFrame:(CGRectMake(0, 0, WIDTH, HEIGHT - 64)) style:(UITableViewStylePlain)];
        _rootTableView.delegate = self;
        _rootTableView.dataSource = self;
        _rootTableView.showsVerticalScrollIndicator = NO;
        _rootTableView.showsHorizontalScrollIndicator = NO;
        _rootTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _rootTableView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self netWorking];
}
-(void)netWorking{
    [self.dataArray setArray:@[@"影魔是基于魔兽争霸3：冰封王座的多人实时对战自定义地图DotA（Defense of the Ancients）里天灾军团的一名敏捷型英雄，位于敏捷（天灾）酒馆内。远攻压制性英雄，前期压制，后期抓人。影魔是基于魔兽争霸3：冰封王座的多人实时对战自定义地图DotA（Defense of the Ancients）里天灾军团的一名敏捷型英雄，位于敏捷（天灾）酒馆内。",@"Nevermore是一种能吸收身体周围的灵魂的生物。他虽然是来自燃烧军团的魔鬼，但是却讨厌和同类的魔鬼一样蠕动，于是便重新伪装了自己。当影魔投入到战斗的时候，便能通过吸收灵魂来增强自己的力量，还能用他被灵魂增强过的攻击以及强力的精神冲击去击败对手。在遭遇过他的少数幸存者的心目中，影魔是最恐怖的对手，而那些被他残暴地杀死的人，才算见识过什么是世界上最卑鄙的杀人手段。",@"一技能具有爆发技能、PUSH技能、FARM技能额效果；FARM速度很强，刷钱能力强，通常能领先对面后期一个大件；二技能提供60点攻击力，为SF的DPS能力提供了一定的屏障，尤其是前中期，60多点附加攻击力是很可怖的存在；如果能放出一个完美大那么团战已经赢了一半了；影魔前期的法术爆发不遑多让，后期的物理输出也骇人听闻。一个优秀的SF通常能掌控全场，无论是前期还是后期。",@"一技能具有爆发技能、PUSH技能、FARM技能额效果；FARM速度很强，刷钱能力强，通常能领先对面后期一个大件；二技能提供60点攻击力",@"一技能具有爆发技能、PUSH技能"]];
    self.showDictionary = [[NSMutableDictionary alloc]init];
    [self.view addSubview:self.rootTableView];
}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  [HeightModel cellHeightWith:self.dataArray[indexPath.row] andIsShow:[[self.showDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue] andLableWidth:WIDTH - 30 andFont:12 andDefaultHeight:15 andFixedHeight:24 + 15];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DetailTextTableViewCell"];
    if (!cell) {
        cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"DetailTextTableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.delegate = self;
    cell.moreBlock = ^(NSDictionary *dic,NSIndexPath *indexPath){
        [self.showDictionary setObject:[dic objectForKey:@"isShow"] forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"row"]]];
        [self.rootTableView reloadData];
    };
    [cell setCellContent:[self.dataArray objectAtIndex:indexPath.row] andIsShow:[[self.showDictionary objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]] boolValue]  andCellIndexPath:indexPath];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


#pragma mark - TextTableViewCellCellDelegate
- (void)remarksCellShowContrntWithDic:(NSDictionary *)dic andCellIndexPath:(NSIndexPath *)indexPath{
    //更改状态
    [self.showDictionary setObject:[dic objectForKey:@"isShow"] forKey:[NSString stringWithFormat:@"%@",[dic objectForKey:@"row"]]];
    [self.rootTableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
