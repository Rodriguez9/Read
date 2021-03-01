

#import "BaseCollectionViewCell.h"
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface CategoryViewCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) Model *model;
@end

NS_ASSUME_NONNULL_END
