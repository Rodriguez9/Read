

#import "JFRankViewController.h"
#import "Globe.h"
#import "NetWorkManager.h"
#import "APIS.h"
#import "JGModel.h"
#import <YYModel/YYModel.h>
#import "CurrentReadController.h"
#import "ReadViewController.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "JGComicViewController.h"
@interface JFRankViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *category2;
@property(nonatomic, strong) NSMutableArray<JGRankModel *> *rankList;
@end

@implementation JFRankViewController

-(NSMutableArray<JGRankModel *> *)rankList{
    if (!_rankList) {
        _rankList = [NSMutableArray<JGRankModel *> array];
    }
    return _rankList;
}

-(UITableView *)category2{
    if (!_category2) {
        _category2 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _category2.backgroundColor = [UIColor grayColor];
        [_category2 registerClass:[JGRankViewCell class] forCellReuseIdentifier:@"JGRankViewCell"];
        _category2.tableFooterView = [[UIView alloc] init];
        _category2.separatorStyle = UITableViewCellSeparatorStyleNone;
        _category2.backgroundColor = [UIColor lightTextColor];
        _category2.delegate = self;
        _category2.dataSource = self;
    }
    return _category2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self loadData];
    self.view.backgroundColor = [UIColor lightGrayColor];
}

-(void)loadData{
    NetWorkManager *Nettool =  [NetWorkManager netWorkManager];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,TopRankList];
    [Nettool getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray *rankList = [[responseObject objectForKey:@"ranking"] objectForKey:@"books"];
        [rankList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JGRankModel *model = [JGRankModel yy_modelWithJSON:obj];
            [self.rankList addObject:model];
            [self.category2 reloadData];
        }];
    } failure:^(NSError *error) {
    
    }];
}

- (void)configUI{
    [self.view addSubview:self.category2];
    [self.category2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
    
}

#pragma marl - Delegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        JGRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(JGRankViewCell.class)];
        if (!cell) {
            cell = [[JGRankViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(JGRankViewCell.class)];
        }
        cell.model = self.rankList[indexPath.row];
        cell.Num.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
       return self.rankList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    JGRankModel *model = self.rankList[indexPath.row];
    JGComicViewController *vc = [[JGComicViewController alloc] init:model.title cover:model.cover author:model.author major:model.majorCate minor:model.minorCate shortIntro:model.shortIntro];
       [self presentViewController:vc animated:YES completion:nil];
   
}

@end











