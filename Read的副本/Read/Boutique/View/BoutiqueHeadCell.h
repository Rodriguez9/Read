
#import <UIKit/UIKit.h>
#import "Model.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueHeadCell : UICollectionReusableView
@property (nonatomic,strong) UILabel *category;
@property (nonatomic,strong) CategoryModel *model;
@end

NS_ASSUME_NONNULL_END
