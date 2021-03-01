#import "BoutiqueListViewController.h"
#import "ComicViewController.h"
@interface BoutiqueListViewController ()

@end

@implementation BoutiqueListViewController

-(UITableView *)BoutiqueList{
    if (!_BoutiqueList) {
        _BoutiqueList = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _BoutiqueList.backgroundColor = [UIColor whiteColor];
        [_BoutiqueList registerClass:[RankViewCell class] forCellReuseIdentifier:@"RankViewCell"];
        _BoutiqueList.tableFooterView = [[UIView alloc] init];
        _BoutiqueList.separatorStyle = UITableViewCellSeparatorStyleNone;
        _BoutiqueList.backgroundColor = [UIColor lightTextColor];
        _BoutiqueList.delegate = self;
        _BoutiqueList.dataSource = self;
    }
    return _BoutiqueList;
}

- (instancetype)init:(NSArray *)Boutique
{
    self = [super init];
    if (self) {
        self.Boutique = Boutique;
    }
    return self;
}

- (void)configUI{
    [self.view addSubview:self.BoutiqueList];
    [self.BoutiqueList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view);
        }
    }];
    
}

#pragma marl - Delegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Boutique.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        RankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(RankViewCell.class)];
        if (!cell) {
            cell = [[RankViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(RankViewCell.class)];
        }
        cell.model = self.Boutique[indexPath.row];
        cell.Num.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    RankModel *model = self.Boutique[indexPath.row];
    ComicViewController *vc = [[ComicViewController alloc] init:model.title cover:model.cover author:model.author major:@"" minor:@"" shortIntro:model.shortIntro];
       [self presentViewController:vc animated:YES completion:nil];

}


@end
