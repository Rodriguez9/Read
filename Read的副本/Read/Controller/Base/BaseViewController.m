

#import "BaseViewController.h"
#import "UINavigationController+back.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    if (@available(iOS 11.0, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = false;
    }
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configNavigationBar];
}

-(void)configUI{
}

-(void)configNavigationBar{
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    UINavigationController *nav = self.navigationController;
    if (nav.visibleViewController == self) {
        [nav barStyle:theme];
        [nav setNavigationBarHidden:false animated:true];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent ;
}

@end

