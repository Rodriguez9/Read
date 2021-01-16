

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.grayColor;
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    [self configUI];
    
}

-(void)configUI{
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent ;
}

@end

