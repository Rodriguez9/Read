
#import "CategoryViewController.h"
#import "CategoryViewCell.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <YYModel/YYModel.h>
#import "NetWorkManager.h"
#import "BoutiqueListController.h"
@interface CategoryViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation CategoryViewController

- (NSMutableArray<Model *> *)CategoryList{
    if (!_CategoryList) {
        _CategoryList = [NSMutableArray<Model *> array];
    }
    return _CategoryList;
}

- (UIButton *)sexTypeButton{
    if (!_sexTypeButton) {
        _sexTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    [_sexTypeButton addTarget:self action:@selector(changsex) forControlEvents:UIControlEventTouchUpInside];
    return _sexTypeButton;
}

-(UICollectionView *)cw{
    UICollectionViewFlowLayout *lt = [UICollectionViewFlowLayout new];
    lt.minimumInteritemSpacing = 5;
    lt.minimumLineSpacing = 10;
    if (!_cw) {
        _cw = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lt];
        _cw.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.99];
        _cw.alwaysBounceVertical = true;
        _cw.contentInset = UIEdgeInsetsMake(0, 8, 0, 8);
        _cw.scrollIndicatorInsets = _cw.contentInset;
        [_cw registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
        _cw.delegate = self;
        _cw.dataSource = self;
    }
    return _cw;
}

- (void)configUI{
    [self.view addSubview:self.cw];
    [self.cw mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        } else {
            make.top.equalTo(self.view);
        }
        make.left.right.bottom.equalTo(self.view);
    }];
}

-(void)loadData:(BOOL)changsex{
   
    NetWorkManager *manager = [NetWorkManager netWorkManager];
     NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Category];
    [manager getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray <NSDictionary *>*Malearr = [responseObject valueForKey:@"female"];
        NSMutableArray<Model *> *modelarr = [NSMutableArray<Model *> array];
        [Malearr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            Model *model = [Model yy_modelWithJSON:obj];
            [modelarr addObject:model];
        }];
        self.CategoryList = modelarr;
        [self.cw reloadData];
    } failure:^(NSError *error) {
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData:false];
}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryViewCell" forIndexPath:indexPath];
          if (!cell) {
              cell = [[CategoryViewCell alloc] initWithFrame:CGRectZero];
          }
          cell.model = self.CategoryList[indexPath.row];
          return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.CategoryList.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width;
    
    width = floor((ScreenWidth - 40.0)/2.0);
    
    return CGSizeMake(width,300);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BoutiqueListController *Boutiquelist = [[BoutiqueListController alloc] init:self.CategoryList[indexPath.row].name];
    [self.navigationController pushViewController:Boutiquelist animated:YES];
}


@end
