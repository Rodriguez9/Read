#import "ComicViewController.h"
#import "UINavigationController+back.h"
#import "ComicHead.h"
#import "APIS.h"
#import "Globe.h"
#import <Masonry.h>
#import <YYModel/YYModel.h>
#import "CurrentReadController.h"
#import "ReadViewController.h"
#import "BoutiqueViewCell.h"
#import "BoutiqueHeadCell.h"
#import "NetWorkManager.h"
#import "UIImage+Blur.h"

@interface ComicViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *cw;
@property(nonatomic, strong) NSMutableArray<BookModel *> *rankList;
@property(nonatomic, strong) NSMutableArray<BookModel *> *BoutiqueList;
@end

@implementation ComicViewController

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] init];
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
        _backImg.clipsToBounds = YES;
        _backImg.autoresizesSubviews = YES;
        _backImg.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:0.99];
       
    }
    return _backImg;;
}

-(ComicHead *)ComicHead{
    if (!_ComicHead) {
        _ComicHead = [[ComicHead alloc] init:_bookName coverImg:_cover shortIntro:_shortIntro];
    }
    return _ComicHead;
}

-(NSMutableArray<BookModel *> *)rankList{
    if (!_rankList) {
        _rankList = [NSMutableArray<BookModel *> array];
    }
    return _rankList;
}

-(NSMutableArray<BookModel *> *)BoutiqueList{
    if (!_BoutiqueList) {
        _BoutiqueList = [NSMutableArray<BookModel *> array];
    }
    return _BoutiqueList;
}

-(UIView *)separate{
    if (!_separate) {
        _separate = [[UIView alloc] init];
        _separate.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.99];
    }
    return _separate;
}



-(UICollectionView *)cw{
    UICollectionViewFlowLayout *lt = [UICollectionViewFlowLayout new];
    lt.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
    lt.scrollDirection = UILayoutConstraintAxisHorizontal;
    if (!_cw) {
        _cw = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:lt];
        _cw.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.99];
        _cw.alwaysBounceVertical = true;
        _cw.scrollIndicatorInsets = _cw.contentInset;
        [_cw registerClass:[BoutiqueViewCell class] forCellWithReuseIdentifier:@"BoutiqueViewCell"];
        [_cw registerClass:[BoutiqueHeadCell class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueHeadCell"];
        _cw.layer.cornerRadius = 5;
        _cw.delegate = self;
        _cw.dataSource = self;
    }
    return _cw;
}

-(UIButton *)ReadButton{
    if (!_ReadButton) {
        _ReadButton = [[UIButton alloc] init];
        [_ReadButton setTitle:@"开始阅读" forState:UIControlStateNormal];
        [_ReadButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _ReadButton.backgroundColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.99];
        [_ReadButton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ReadButton;
}

- (UIButton *)AddbookButton{
    if (!_AddbookButton) {
        _AddbookButton = [[UIButton alloc] init];
        [_AddbookButton setTitle:@"加入书架" forState:UIControlStateNormal];
        [_AddbookButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _AddbookButton.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.99];
        [_AddbookButton addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AddbookButton;
}

- (instancetype)init:(NSString*)bookName
               cover:(NSString*)cover
              author:(NSString*)author
               major:(NSString*)major
               minor:(NSString*)minor
          shortIntro:(NSString *)shortIntro
{
    self = [super init];
    _cover = cover;
    _bookName = bookName;
    _author = author;
    _majorCate = major;
    _minorCate = minor;
    _shortIntro = shortIntro;
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)configNavigationBar{
    [super configNavigationBar];
    [self.navigationController barStyle:clear];
}


-(void)Click:(UIButton *)sender{
    if (sender == self.AddbookButton) {
        [sender setTitle:@"已添加" forState:UIControlStateNormal];
        NSDictionary *dic=@{@"bookName":self.bookName,
                            @"cover":self.cover,
                            @"author":self.author,
                            @"major":self.majorCate,
                            @"minor":self.minorCate,
                            @"shortIntro":self.shortIntro,
                            };
        NSMutableDictionary *book = [NSMutableDictionary dictionary];
        [book setObject:dic forKey:@"book"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:bookshelfKey
                                                            object:nil
                                                          userInfo:book
         ];
        [userdefault synchronize];
    }else{
        ReadViewController *vc = [[ReadViewController alloc] init];
        NSString *bookName = [NSString stringWithFormat:@"%d", arc4random()%6];
        vc.bookName = bookName;
        vc.hidesBottomBarWhenPushed = true;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
    }
       
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
}

-(void)loadData{
    NetWorkManager *Nettool =  [NetWorkManager netWorkManager];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,WeakRankList];
    [Nettool getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray *rankList = [[responseObject objectForKey:@"ranking"] objectForKey:@"books"];
        [rankList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BookModel *model = [BookModel yy_modelWithJSON:obj];
            [self.rankList addObject:model];
            [self.cw reloadData];
        }];
    } failure:^(NSError *error) {
    
    }];
}

- (void)configUI{
    
    [self.view addSubview:self.backImg];
    
    [self.view addSubview:self.ComicHead];
       [self.ComicHead mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 15, 15, 15));
           if (@available(iOS 11.0, *)) {
               make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
           } else {
               make.top.equalTo(self.view);
           }
           make.height.mas_equalTo(ScreenHeight/5);
       }];

    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.ComicHead.mas_bottom).offset(15);
    }];
    
    [self.view addSubview:self.AddbookButton];
    [self.AddbookButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.mas_equalTo(ScreenWidth/2.0);
        make.height.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.ReadButton];
    [self.ReadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(80);
        make.left.equalTo(self.AddbookButton.mas_right);
    }];
    
    [self.view addSubview:self.separate];
     [self.separate mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.ComicHead.mas_bottom).with.offset(5);
         make.left.equalTo(self.view.mas_left);
         make.right.equalTo(self.view.mas_right);
         make.height.mas_equalTo(1);
     }];
    
    [self.view addSubview:self.cw];
    [self.cw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ComicHead.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.ReadButton.mas_top).with.offset(-10);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 15, 0));
       }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rankList.count == 0 ? 0 : self.rankList.count > 6 ? 6 : self.rankList.count;;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BoutiqueViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BoutiqueViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.model = self.rankList[arc4random()%self.rankList.count];
    [self.BoutiqueList addObject:cell.model];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
           BoutiqueHeadCell *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BoutiqueHeadCell" forIndexPath:indexPath];
        header.category.text = @"猜你喜欢";
        return header;
       }
       return [UICollectionReusableView new];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(ScreenWidth, 90);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width = floor((ScreenWidth - 40.0)/3.0);
    return CGSizeMake(width, ScreenHeight/5.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    BookModel *model = self.BoutiqueList[indexPath.row];
    ComicViewController *vc = [[ComicViewController alloc] init:model.title cover:model.cover author:model.author major:self.majorCate minor:self.minorCate shortIntro:model.shortIntro];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
