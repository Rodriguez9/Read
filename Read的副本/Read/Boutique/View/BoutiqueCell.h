
#import "BaseCollectionViewCell.h"
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) BookModel *model;
@property (nonatomic,strong) UILabel *desLabel;
@end

NS_ASSUME_NONNULL_END
