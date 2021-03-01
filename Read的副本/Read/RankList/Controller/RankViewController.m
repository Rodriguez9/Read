

#import "RankViewController.h"
#import "Globe.h"
#import "NetWorkManager.h"
#import "APIS.h"
#import "Model.h"
#import <YYModel/YYModel.h>
#import "CurrentReadController.h"
#import "ReadViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "ComicViewController.h"
#import "RankHeadView.h"
#import "BoutiqueFootCell.h"
@interface RankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *table;
@property(nonatomic, strong) NSMutableArray<NSArray *> *rankList;
@property(nonatomic, strong) NSMutableArray<RankTypeModel *> *rankTypeList;
@end

@implementation RankViewController

-(NSMutableArray<RankTypeModel *> *)rankTypeList{
    if (!_rankTypeList) {
        _rankTypeList = [NSMutableArray<RankTypeModel *> array];
    }
    return _rankTypeList;
}

-(NSMutableArray<NSArray *> *)rankList{
    if (!_rankList) {
        _rankList = [NSMutableArray<NSArray *> array];
    }
    return _rankList;
}

-(UITableView *)table{
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.backgroundColor = [UIColor whiteColor];
        [_table registerClass:[RankViewCell class] forCellReuseIdentifier:@"RankViewCell"];
        [_table registerClass:[RankHeadView class] forHeaderFooterViewReuseIdentifier:@"RankHeadView"];
        _table.tableFooterView = [[UIView alloc] init];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _table.backgroundColor = [UIColor lightTextColor];
        _table.delegate = self;
        _table.dataSource = self;
    }
    return _table;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadData];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.rankList = nil;
}

-(void)loadData{
    NetWorkManager *Nettool =  [NetWorkManager netWorkManager];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,@"/ranking/gender"];
    [Nettool getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray *rankList = [[responseObject objectForKey:@"female"] subarrayWithRange:NSMakeRange(0, 4)];
        [rankList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RankTypeModel *model = [RankTypeModel yy_modelWithJSON:obj];
            [self.rankTypeList addObject:model];
            NSString *str = [NSString stringWithFormat:@"%@/ranking/%@",BaseUrl,model._id];
            [Nettool getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
                NSArray *rankList = [[[responseObject objectForKey:@"ranking"] objectForKey:@"books"]  subarrayWithRange:NSMakeRange(0, 4)];
                NSMutableArray *arrbookModel = [NSMutableArray array];
                [rankList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    RankModel *model = [RankModel yy_modelWithJSON:obj];
                    [arrbookModel addObject:model];
                }];
                [self.rankList addObject:arrbookModel];
                [self.table reloadData];
                } failure:^(NSError *error) {
                
            }];
            [self.table reloadData];
    }];
    } failure:^(NSError *error) {
    }];
}

- (void)configUI{
    [self.view addSubview:self.table];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view);
        }
    }];
    
}

#pragma marl - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.rankList.count;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rankList.count == 0 ? 0 : self.rankList[section].count > 8 ? 8 : self.rankList[section].count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        RankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RankViewCell.class)];
        if (!cell) {
            cell = [[RankViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RankViewCell.class)];
        }
        cell.model = self.rankList[indexPath.section][indexPath.row];
        cell.Num.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    RankHeadView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(RankHeadView.class)];
    view.backgroundColor = [UIColor whiteColor];
    view.model = self.rankTypeList[section];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    RankModel *model = self.rankList[indexPath.section][indexPath.row];
    ComicViewController *vc = [[ComicViewController alloc] init:model.title cover:model.cover author:model.author major:model.majorCate minor:model.minorCate shortIntro:model.shortIntro];
       [self presentViewController:vc animated:YES completion:nil];
   
}

@end











