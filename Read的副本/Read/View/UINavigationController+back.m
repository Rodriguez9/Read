#import "UINavigationController+back.h"

@implementation UINavigationController (back)

-(void)barStyle:(NavigationBarStyle)style{
    switch (style) {
        case theme:{
            self.navigationBar.barStyle = 0;
            UIImage *img = [self image:[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:0.99]];
            self.navigationBar.shadowImage = [UIImage new];
            [self.navigationBar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        }
            break;
        case clear:
            self.navigationBar.barStyle = 0;
            [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
            [self.navigationBar setShadowImage:[UIImage new]];
            break;
    }
}

-(UIImage *)image:(UIColor *)color{
    CGSize navigationBarSize = self.navigationBar.frame.size;
    UIGraphicsBeginImageContext(navigationBarSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, navigationBarSize.width, navigationBarSize.height));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

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
