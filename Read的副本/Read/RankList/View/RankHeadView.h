#import <UIKit/UIKit.h>
#import "Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface RankHeadView : UITableViewHeaderFooterView
@property (nonatomic,strong) UILabel *category;
@property (nonatomic,strong) RankTypeModel *model;
@end

NS_ASSUME_NONNULL_END
