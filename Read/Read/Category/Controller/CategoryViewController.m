//
//  CategoryViewController.m
//  Read
//
//  Created by Jarvis on 2021/1/14.
//  Copyright © 2021 Jarvis. All rights reserved.
//

#import "CategoryViewController.h"
#import "CategoryViewCell.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <YYModel/YYModel.h>
#import "NetWorkManager.h"
#import "JGBoutiqueListController.h"
@interface CategoryViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@end

@implementation CategoryViewController

- (NSMutableArray<JGModel *> *)CategoryList{
    if (!_CategoryList) {
        _CategoryList = [NSMutableArray<JGModel *> array];
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
    
    [self.view addSubview:self.sexTypeButton];
    [self.sexTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(60);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-20);
    }];
}

-(void)loadData:(BOOL)changsex{
    if (changsex) {
        NSString *sex = [[userdefault objectForKey:sexTypeKey]  isEqual: @"female"] ? @"male" : @"female";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sexTypeKey" object:nil userInfo:@{@"sex": sex}];
        [userdefault synchronize];
    }
    [self.sexTypeButton setImage:[UIImage imageNamed:[self.sexType isEqual:@"male"] ? @"gender_male" : @"gender_female"] forState:UIControlStateNormal];
    NetWorkManager *manager = [NetWorkManager netWorkManager];
     NSString *str = [NSString stringWithFormat:@"%@%@",BaseUrl,Category];
    [manager getRequestUrl:str withPramater:nil sucess:^(id responseObject) {
        NSArray <NSDictionary *>*Malearr = [responseObject valueForKey:self.sexType];
        NSMutableArray<JGModel *> *modelarr = [NSMutableArray<JGModel *> array];
        [Malearr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            JGModel *model = [JGModel yy_modelWithJSON:obj];
            [modelarr addObject:model];
        }];
        self.CategoryList = modelarr;
        [self.cw reloadData];
    } failure:^(NSError *error) {
    }];
    
}

-(void)changsex{
    [self loadData:true];
    
}

-(void)noticeCallback:(NSNotification*)notification{
    NSUserDefaults *sexDefault = [NSUserDefaults standardUserDefaults];
    [sexDefault setValue:notification.userInfo[@"sex"] forKey:sexTypeKey];
    self.sexType = notification.userInfo[@"sex"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sexType = SexType;
    [self loadData:false];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeCallback:) name:sexTypeKey object:nil];
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
    
    width = floor((ScreenWidth - 30.0)/3.0);
    
    return CGSizeMake(width, ScreenHeight/7.0);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    JGBoutiqueListController *Boutiquelist = [[JGBoutiqueListController alloc] init:self.CategoryList[indexPath.row].name];
    [self.navigationController pushViewController:Boutiquelist animated:YES];
}


@end
