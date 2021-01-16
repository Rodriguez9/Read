#import "JGMineViewController.h"
#import "JGMineTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface JGMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *Mine;
@property(nonatomic, strong) NSArray *arrList;
@property(nonatomic, strong) MBProgressHUD *HUD;
@property(nonatomic, strong) NSString *date;
@end

@implementation JGMineViewController

-(NSArray *)arrList{
    _arrList = [NSArray array];
    _arrList = @[@"清理缓存",@"版本"];
    return _arrList;
}

-(UITableView *)Mine{
    if (!_Mine) {
        _Mine = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _Mine.backgroundColor = [UIColor grayColor];
        [_Mine registerClass:[JGMineTableViewCell class] forCellReuseIdentifier:@"JGMineTableViewCell"];
        _Mine.tableFooterView = [[UIView alloc] init];
        _Mine.separatorStyle = UITableViewCellSelectionStyleGray;
        _Mine.separatorColor = [UIColor darkGrayColor];
        _Mine.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20);
        _Mine.backgroundColor = [UIColor whiteColor];
        _Mine.delegate = self;
        _Mine.dataSource = self;
    }
    return _Mine;
}


- (void)viewDidLoad {
    self.date = [NSString stringWithFormat:@"%u%@",arc4random()%500,@"KB"];
    [super viewDidLoad];
}

- (void)configUI{
    [self.view addSubview:self.Mine];
    [self.Mine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
       make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
    }];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    JGMineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(JGMineTableViewCell.class)];
        if (!cell) {
            cell = [[JGMineTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass(JGMineTableViewCell.class)];
        }
        cell.title.text = self.arrList[indexPath.row];
    
    if (indexPath.row == 0) {
        cell.coverImg.image = [UIImage imageNamed:@"clear"];
        cell.detail.text = self.date;
    }
    if (indexPath.row == 1) {
        cell.coverImg.image = [UIImage imageNamed:@"version"];
        cell.detail.text = @"v1.01";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        [self GeneralButtonAction];
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 70;
}

- (void)GeneralButtonAction{
    self.HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:self.HUD];
    self.HUD.label.text =@"清理中";
    self.HUD.detailsLabel.text =@"请耐心等待";
    self.HUD.mode = MBProgressHUDModeAnnularDeterminate;
    [self.HUD showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.HUD removeFromSuperview];
        self.date = @"";
        [self.Mine reloadData];
        self.HUD =nil;
    });
}

@end
