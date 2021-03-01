#import "BoutiqueListController.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <YYModel/YYModel.h>
#import "Model.h"
#import "NetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "BoutiqueCell.h"
#import "BoutiqueHeadCell.h"
#import "BoutiqueFootCell.h"
#import "ComicViewController.h"
#import "UINavigationController+back.h"
#import "BoutiqueViewCell.h"
#import "BoutiqueListViewController.h"
#import "ComicViewController.h"
@interface BoutiqueListController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation BoutiqueListController

- (NSArray *)Small_category{
    if (!_Small_category) {
        _Small_category = [NSArray array];
    }
    return _Small_category;
}

- (NSMutableArray<NSArray *> *)Book{
    if (!_Book) {
        _Book = [NSMutableArray<NSArray *> array];
    }
    return _Book;
}

-(UICollectionView *)cw{
    UICollectionViewFlowLayout *lt = [UICollectionViewFlowLayout new];
    lt.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    lt.scrollDirection = UILayoutConstraintAxisHorizontal;
    if (!_cw) {
        _cw = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lt];
        _cw.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.99];
        _cw.alwaysBounceVertical = true;
        _cw.scrollIndicatorInsets = _cw.contentInset;
        [_cw registerClass:[BoutiqueCell class] forCellWithReuseIdentifier:@"BoutiqueCell"];
        [_cw registerClass:[BoutiqueViewCell class] forCellWithReuseIdentifier:@"BoutiqueViewCell"];
        [_cw registerClass:[BoutiqueHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueHeadCell"];
        [_cw registerClass:[BoutiqueFootCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BoutiqueFootCell"];
        _cw.delegate = self;
        _cw.dataSource = self;
    }
    return _cw;
}

-(instancetype)init:(NSString *)title{
    if (!self) {
        self = [super init];
    }
    self.titles = title;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

- (void)configNavigationBar{
    [super configNavigationBar];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.backBarButtonItem = backItem;
}

-(void)loadData{
    NetWorkManager *manager = [NetWorkManager netWorkManager];
     NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Small_Category];
    [manager getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray <NSDictionary *>*Malearr = [[responseObject valueForKey:@"female"] subarrayWithRange:NSMakeRange(0, 7)];
         NSArray *Majorarr = [[Malearr valueForKey:@"major"] subarrayWithRange:NSMakeRange(0, 7)];
        [Majorarr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:self.titles]) {
                self.Small_category = [Malearr[idx] valueForKey:@"mins"];
                 NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Picture_Category];
                [self.Small_category enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [manager getRequestUrl:str withPramater:@{
                        @"gender":@"female",
                        @"major":self.titles,
                        @"minor":obj
                    } sucess:^(id responseObject) {
                         ListModel *categorylistmodel = [ListModel yy_modelWithJSON:responseObject];
                        NSArray *arrbook = categorylistmodel.books;
                        NSMutableArray *arrbookModel = [NSMutableArray array];
                        [arrbook enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [arrbookModel addObject:[BookModel yy_modelWithJSON:obj]];
                        }];
                        [self.Book addObject:arrbookModel];
                        [self.cw reloadData];
                    } failure:^(NSError *error) {
                    }];
                    [self.cw reloadData];
                }];
                
            }
        }];
    } failure:^(NSError *error) {

    }];
}


- (void)configUI{
    [self.view addSubview:self.cw];
    [self.cw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 15, 0));
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.Book.count;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.Book.count == 0 ? 0 : self.Book[section].count > 6 ? 6 : self.Book[section].count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
         BoutiqueViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueViewCell" forIndexPath:indexPath];
                   if (!cell) {
                       cell = [[BoutiqueViewCell alloc] initWithFrame:CGRectZero];
                   }
                   cell.model = self.Book[indexPath.section][indexPath.row];
                   return cell;
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
           BoutiqueHeadCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueHeadCell" forIndexPath:indexPath];
        header.category.text = self.Small_category[indexPath.section];
        return header;
    }else{
        BoutiqueFootCell *foot = [collectionView
            dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                withReuseIdentifier:@"BoutiqueFootCell" forIndexPath:indexPath];
        foot.Allbook = ^{
            BoutiqueListViewController *vc = [[BoutiqueListViewController alloc] init:self.Book[indexPath.section]];
            [self.navigationController pushViewController:vc animated:YES handle:nil];
        };
        return foot;
    }
       
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.Book[section].count != 0) {
        return CGSizeMake(ScreenWidth, 50);
    }else{
        return CGSizeMake(ScreenWidth, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (self.Book[section].count != 0) {
        return CGSizeMake(ScreenWidth, 50);
    }else{
        return CGSizeMake(ScreenWidth, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width;
    double height;
    width = floor((ScreenWidth - 40.0)/3.0);
    height = 120;
    return CGSizeMake(width, height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BookModel *model = self.Book[indexPath.section][indexPath.row];
    ComicViewController *vc = [[ComicViewController alloc] init:model.title cover:model.cover author:model.author major:self.titles minor:self.Small_category[indexPath.section] shortIntro:model.shortIntro];
    [self.navigationController pushViewController:vc animated:YES handle:nil];
}

@end




