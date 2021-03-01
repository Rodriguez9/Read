
#import "BaseViewController.h"
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewController : BaseViewController
@property(nonatomic, strong) UICollectionView *cw;
@property(nonatomic, strong) NSMutableArray<Model *> *CategoryList;
@property(nonatomic, strong) UIButton *sexTypeButton;

@end

NS_ASSUME_NONNULL_END
