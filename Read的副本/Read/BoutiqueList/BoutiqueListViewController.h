#import "BaseViewController.h"
#import "RankViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueListViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView *BoutiqueList;
@property(nonatomic,copy)NSArray *Boutique;
- (instancetype)init:(NSArray *)Boutique;
@end

NS_ASSUME_NONNULL_END
