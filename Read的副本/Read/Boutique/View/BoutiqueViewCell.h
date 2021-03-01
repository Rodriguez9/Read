#import "BaseCollectionViewCell.h"
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueViewCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) BookModel *model;
@end

NS_ASSUME_NONNULL_END
