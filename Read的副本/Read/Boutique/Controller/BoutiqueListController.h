#import "BaseViewController.h"
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueListController : BaseViewController
@property(nonatomic,readwrite)NSString *titles;
@property(nonatomic, strong) UICollectionView *cw;
@property(nonatomic, strong) NSArray *Small_category;
@property(nonatomic, strong) NSMutableArray<NSArray *> *Book;
@property(nonatomic, strong) NSMutableArray<BookModel *> *BookList;
-(instancetype)init:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
