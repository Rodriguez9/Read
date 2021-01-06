//
//  ComicViewController.m
//  Read
//
//  Created by Jarvis on 2021/1/4.
//  Copyright © 2021 Jarvis. All rights reserved.
//

#import "ComicViewController.h"
#import "ComicHead.h"
#import "APIS.h"
#import "Globe.h"
#import <Masonry.h>
#import <YYModel/YYModel.h>
#import "BmwCurrentReadController.h"
#import "BmwReadViewController.h"
#import "BoutiqueListViewCell.h"
#import "BoutiqueHeadCell.h"
#import "NetWorkManager.h"
#import "UIImage+Blur.h"

@interface ComicViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic, strong) UICollectionView *cw;
@property(nonatomic, strong) NSArray *Small_category;
@property(nonatomic, strong) NSMutableArray<CategoryListBookModel *> *rankList;
@end

@implementation ComicViewController

-(UIImageView *)backImg{
    if (!_backImg) {
        _backImg = [[UIImageView alloc] init];
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
        _backImg.layer.borderWidth = 1;
        _backImg.clipsToBounds = YES;
        _backImg.autoresizesSubviews = YES;
        _backImg.image = [[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,_cover]]]] blurredImage:50];
       
    }
    return _backImg;;
}

-(ComicHead *)ComicHead{
    if (!_ComicHead) {
        _ComicHead = [[ComicHead alloc] init:_bookName coverImg:_cover author:_author major:_majorCate minor:_minorCate];
    }
    return _ComicHead;
}

-(NSMutableArray<CategoryListBookModel *> *)rankList{
    if (!_rankList) {
        _rankList = [NSMutableArray<CategoryListBookModel *> array];
    }
    return _rankList;
}

-(UIView *)separate{
    if (!_separate) {
        _separate = [[UIView alloc] init];
        _separate.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.99];
    }
    return _separate;
}

-(UITextView *)ShortIntroText{
    if (!_ShortIntroText) {
        _ShortIntroText = [[UITextView alloc] init];
        _ShortIntroText.userInteractionEnabled = false;
        _ShortIntroText.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.99];
        _ShortIntroText.textColor = UIColor.blackColor;
        _ShortIntroText.text = _shortIntro;
        _ShortIntroText.layer.cornerRadius = 5;
        _ShortIntroText.font = [UIFont systemFontOfSize:20];
    }
    return _ShortIntroText;
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
        [_cw registerClass:[BoutiqueListViewCell class] forCellWithReuseIdentifier:@"BoutiqueListViewCell"];
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
        [_ReadButton addTarget:self action:@selector(ClickButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ReadButton;
}

-(void)ClickButton{
        BmwReadViewController *vc = [[BmwReadViewController alloc] init];
        NSString *bookName = [NSString stringWithFormat:@"%d", arc4random()%6];
        vc.bookName = bookName;
        vc.hidesBottomBarWhenPushed = true;
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:vc animated:YES completion:nil];
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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:true];
}

-(void)loadData{
    NetWorkManager *Nettool =  [NetWorkManager netWorkManager];
    NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,WeakRankList];
    [Nettool getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray *rankList = [[responseObject objectForKey:@"ranking"] objectForKey:@"books"];
        [rankList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CategoryListBookModel *model = [CategoryListBookModel yy_modelWithJSON:obj];
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
           make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
           make.height.mas_equalTo(150);
       }];
    
    [self.view addSubview:self.ShortIntroText];
      [self.ShortIntroText mas_makeConstraints:^(MASConstraintMaker *make) {
          make.top.equalTo(self.ComicHead.mas_bottom);
          make.height.mas_equalTo(ScreenHeight/4);
          make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 15, 15, 15));
      }];
    
    
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.ShortIntroText.mas_top);
    }];
    
    [self.view addSubview:self.ReadButton];
    [self.ReadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(80);
    }];
    
    [self.view addSubview:self.separate];
     [self.separate mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.equalTo(self.self.ShortIntroText.mas_bottom).with.offset(5);
         make.left.equalTo(self.view.mas_left);
         make.right.equalTo(self.view.mas_right);
         make.height.mas_equalTo(1);
     }];
    
    [self.view addSubview:self.cw];
    [self.cw mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ShortIntroText.mas_bottom).with.offset(10);
        make.bottom.equalTo(self.ReadButton.mas_top).with.offset(-10);
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 15, 15, 15));
       }];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.rankList.count == 0 ? 0 : self.rankList.count > 4 ? 4 : self.rankList.count;;
}

- (UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BoutiqueListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoutiqueListViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BoutiqueListViewCell alloc] initWithFrame:CGRectZero];
    }
    cell.model = self.rankList[arc4random()%self.rankList.count];
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
    return CGSizeMake(ScreenWidth, 44);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width = floor((ScreenWidth - 80.0)/2.0);
    return CGSizeMake(width, 130);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    CategoryListBookModel *model = self.Book[indexPath.section][indexPath.row];
//    ComicViewController *vc = [[ComicViewController alloc] init:model.title cover:model.cover author:model.author major:self.titles minor:self.Small_category[indexPath.section] shortIntro:model.shortIntro];
//    //       vc.modalPresentationStyle = UIModalPresentationFullScreen;
//           [self presentViewController:vc animated:YES completion:nil];
}



@end
