#import "BaseViewController.h"
#import "JGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JGBoutiqueListController : BaseViewController
@property(nonatomic,readwrite)NSString *titles;
@property(nonatomic, strong) UICollectionView *cw;
@property(nonatomic, strong) NSArray *Small_category;
@property(nonatomic, strong) NSMutableArray<NSArray *> *Book;
@property(nonatomic, strong) NSMutableArray<JGBookModel *> *BookList;
-(instancetype)init:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
