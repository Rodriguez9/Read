#import "UINavigationController+back.h"

@implementation UINavigationController (back)

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated handle:(void(^ __nullable)(void))handle{
    if (self.viewControllers.count > 0) {
        [viewController setHidesBottomBarWhenPushed:YES];
    }
    [self pushViewController:viewController animated:YES];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController *topVC = [[UINavigationController alloc] topViewController];
    if (topVC) {
        return topVC.preferredStatusBarStyle;
    } else {
        return UIStatusBarStyleLightContent;
    }
}
@end
