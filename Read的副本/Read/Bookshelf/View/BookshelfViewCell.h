

#import "BaseCollectionViewCell.h"
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BookshelfViewCell : BaseCollectionViewCell
@property (nonatomic,strong) UILabel *bookName;
@property (nonatomic,strong) UIImageView *coverImg;
@property (nonatomic,strong) NSDictionary *book;
@property (nonatomic,strong) UILabel *shortIntroLabel;
@end

NS_ASSUME_NONNULL_END
