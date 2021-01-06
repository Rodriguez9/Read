#import "BoutiqueListController.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <YYModel/YYModel.h>
#import "CategoryModel.h"
#import "NetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "BoutiqueListViewCell.h"
#import "BoutiqueHeadCell.h"
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
    lt.minimumInteritemSpacing = 5;
    lt.minimumLineSpacing = 10;
    if (!_cw) {
        _cw = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lt];
        _cw.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.99];
        _cw.alwaysBounceVertical = true;
        _cw.contentInset = UIEdgeInsetsMake(0, 8, 0, 8);
        _cw.scrollIndicatorInsets = _cw.contentInset;
        [_cw registerClass:[BoutiqueListViewCell class] forCellWithReuseIdentifier:@"BoutiqueListViewCell"];
        [_cw registerClass:[BoutiqueHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueHeadCell"];
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

-(void)loadData{
    NetWorkManager *manager = [NetWorkManager netWorkManager];
     NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Small_Category];
    [manager getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray <NSDictionary *>*Malearr = [[responseObject valueForKey:@"male"] subarrayWithRange:NSMakeRange(0, 7)];
         NSArray *Majorarr = [[Malearr valueForKey:@"major"] subarrayWithRange:NSMakeRange(0, 7)];
        [Majorarr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:self.titles]) {
                self.Small_category = [Malearr[idx] valueForKey:@"mins"];
                 NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Picture_Category];
                [self.Small_category enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [manager getRequestUrl:str withPramater:@{
                        @"gender":@"male",
                        @"major":self.titles,
                        @"minor":obj
                    } sucess:^(id responseObject) {
                         CategoryListModel *categorylistmodel = [CategoryListModel yy_modelWithJSON:responseObject];
                        NSArray *arrbook = categorylistmodel.books;
                        NSMutableArray *arrbookModel = [NSMutableArray array];
                        [arrbook enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [arrbookModel addObject:[CategoryListBookModel yy_modelWithJSON:obj]];
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
        make.left.right.bottom.equalTo(self.view);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.Book.count;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.Book.count == 0 ? 0 : self.Book[section].count > 4 ? 4 : self.Book[section].count;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BoutiqueListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueListViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BoutiqueListViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.model = self.Book[indexPath.section][indexPath.row];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
           BoutiqueHeadCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueHeadCell" forIndexPath:indexPath];
        header.category.text = [NSString stringWithFormat:@"%@%@",self.Small_category[indexPath.section],@" >"];
        return header;
       }
       return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.Book[section].count != 0) {
        return CGSizeMake(ScreenWidth, 44);
    }else{
        return CGSizeMake(ScreenWidth, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width = floor((ScreenWidth - 30.0)/2.0);
    return CGSizeMake(width, 150);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryListBookModel *model = self.Book[indexPath.section][indexPath.row];
    ComicViewController *vc = [[ComicViewController alloc] init:model.title cover:model.cover author:model.author major:self.titles minor:self.Small_category[indexPath.section] shortIntro:model.shortIntro];
//           vc.modalPresentationStyle = UIModalPresentationFullScreen;
//           [self presentViewController:vc animated:YES completion:nil];
    [self.navigationController pushViewController:vc animated:true];
}

@end




