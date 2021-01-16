
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol MenuViewDelegate;
@interface TopMenuView : UIView
@property (nonatomic,weak)id<MenuViewDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
