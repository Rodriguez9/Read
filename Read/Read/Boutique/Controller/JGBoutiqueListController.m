#import "JGBoutiqueListController.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <YYModel/YYModel.h>
#import "JGModel.h"
#import "NetWorkManager.h"
#import <AFNetworking/AFNetworking.h>
#import "JGBoutiqueCell.h"
#import "JGBoutiqueHeadCell.h"
#import "JGComicViewController.h"
#import "UINavigationController+back.h"
#import "JGBoutiqueViewCell.h"
@interface JGBoutiqueListController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation JGBoutiqueListController

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
        [_cw registerClass:[JGBoutiqueCell class] forCellWithReuseIdentifier:@"JGBoutiqueCell"];
        [_cw registerClass:[JGBoutiqueViewCell class] forCellWithReuseIdentifier:@"JGBoutiqueViewCell"];
        [_cw registerClass:[JGBoutiqueHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JGBoutiqueHeadCell"];
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

//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//}

-(void)loadData{
    NetWorkManager *manager = [NetWorkManager netWorkManager];
     NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Small_Category];
    [manager getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray <NSDictionary *>*Malearr = [[responseObject valueForKey:SexType] subarrayWithRange:NSMakeRange(0, 5)];
         NSArray *Majorarr = [[Malearr valueForKey:@"major"] subarrayWithRange:NSMakeRange(0, 5)];
        [Majorarr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:self.titles]) {
                self.Small_category = [Malearr[idx] valueForKey:@"mins"];
                 NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Picture_Category];
                [self.Small_category enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [manager getRequestUrl:str withPramater:@{
                        @"gender":SexType,
                        @"major":self.titles,
                        @"minor":obj
                    } sucess:^(id responseObject) {
                         JGListModel *categorylistmodel = [JGListModel yy_modelWithJSON:responseObject];
                        NSArray *arrbook = categorylistmodel.books;
                        NSMutableArray *arrbookModel = [NSMutableArray array];
                        [arrbook enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [arrbookModel addObject:[JGBookModel yy_modelWithJSON:obj]];
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
        
    if (indexPath.section%2 == 0 && indexPath.row != 0 && self.Book[indexPath.section].count >= 4) {
         JGBoutiqueViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JGBoutiqueViewCell" forIndexPath:indexPath];
                   if (!cell) {
                       cell = [[JGBoutiqueViewCell alloc] initWithFrame:CGRectZero];
                   }
                   cell.model = self.Book[indexPath.section][indexPath.row];
                   return cell;
    } else {
         JGBoutiqueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JGBoutiqueCell" forIndexPath:indexPath];
               if (!cell) {
                   cell = [[JGBoutiqueCell alloc] initWithFrame:CGRectZero];
               }
               cell.model = self.Book[indexPath.section][indexPath.row];
               return cell;
    }
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
           JGBoutiqueHeadCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"JGBoutiqueHeadCell" forIndexPath:indexPath];
        header.category.text = self.Small_category[indexPath.section];
        return header;
       }
       return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (self.Book[section].count != 0) {
        return CGSizeMake(ScreenWidth, 50);
    }else{
        return CGSizeMake(ScreenWidth, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width;
    
    if (indexPath.section%2 == 0 && indexPath.row != 0 && self.Book[indexPath.section].count >= 4) {
       width = floor((ScreenWidth - 30.0)/3.0);
    }else{
        width = floor(ScreenWidth - 30.0);
    }
    return CGSizeMake(width, ScreenHeight/8.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JGBookModel *model = self.Book[indexPath.section][indexPath.row];
    JGComicViewController *vc = [[JGComicViewController alloc] init:model.title cover:model.cover author:model.author major:self.titles minor:self.Small_category[indexPath.section] shortIntro:model.shortIntro];
    [self.navigationController pushViewController:vc animated:YES handle:nil];
}

@end




