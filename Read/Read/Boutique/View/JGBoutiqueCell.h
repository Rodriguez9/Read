
#import "BaseCollectionViewCell.h"
#import "JGModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface JGBoutiqueCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) JGBookModel *model;
@property (nonatomic,strong) UILabel *desLabel;
@end

NS_ASSUME_NONNULL_END
