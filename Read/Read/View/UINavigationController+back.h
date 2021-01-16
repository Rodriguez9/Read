#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationController (back)
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated handle:(void(^ __nullable)(void))handle;
@end

NS_ASSUME_NONNULL_END
