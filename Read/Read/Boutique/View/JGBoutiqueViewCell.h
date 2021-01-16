#import "BaseCollectionViewCell.h"
#import "JGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JGBoutiqueViewCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) JGBookModel *model;
@end

NS_ASSUME_NONNULL_END
