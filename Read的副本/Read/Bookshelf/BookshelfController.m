

#import "BookshelfController.h"
#import "BookshelfViewCell.h"
#import "ReadViewController.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <YYModel/YYModel.h>
#import "NetWorkManager.h"
#import "BoutiqueListController.h"
@interface BookshelfController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property(nonatomic, strong) NSMutableArray *bookLibrary;
@end

@implementation BookshelfController

- (NSMutableArray *)bookLibrary{
    if (!_bookLibrary) {
        _bookLibrary = [NSMutableArray array];
    }
    return _bookLibrary;
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
        [_cw registerClass:[BookshelfViewCell class] forCellWithReuseIdentifier:@"BookshelfViewCell"];
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

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.bookLibrary =  bookshelf;
    [self.cw reloadData];
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    BookshelfViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookshelfViewCell" forIndexPath:indexPath];
          if (!cell) {
              cell = [[BookshelfViewCell alloc] initWithFrame:CGRectZero];
          }
    cell.book = self.bookLibrary[indexPath.row];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.bookLibrary.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    double width;
    
    width = floor(ScreenWidth - 30.0);
    
    return CGSizeMake(width, 130);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ReadViewController *vc = [[ReadViewController alloc] init];
    NSString *bookName = [NSString stringWithFormat:@"%d", arc4random()%6];
    vc.bookName = bookName;
    vc.hidesBottomBarWhenPushed = true;
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
