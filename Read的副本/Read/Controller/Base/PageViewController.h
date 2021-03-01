

#import "BaseViewController.h"
#import "HMSegmentedControl.h"
NS_ASSUME_NONNULL_BEGIN

@interface PageViewController : BaseViewController
- (instancetype)init:(NSArray <NSString *>*)titles vcs:(NSArray <UIViewController *> *)vcs;
@property(nonatomic, strong) HMSegmentedControl *segment;
@property(nonatomic, strong) UIPageViewController *pageVC;
@property(nonatomic,readwrite)NSArray <UIViewController *> *vcs;
@property(nonatomic,readwrite)NSArray <NSString *> *titles;
@property (nonatomic,strong) UIView *separate;
-(void)changeIndex:(UISegmentedControl *)segment;
@end

NS_ASSUME_NONNULL_END
