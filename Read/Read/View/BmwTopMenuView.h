
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol BmwMenuViewDelegate;
@interface BmwTopMenuView : UIView
@property (nonatomic,weak)id<BmwMenuViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
