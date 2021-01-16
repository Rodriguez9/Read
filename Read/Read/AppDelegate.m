

#import "AppDelegate.h"
#import "TabBarController.h"
#import "APIS.h"
#import "Globe.h"
#import "ReadStateDefault.h"
@interface AppDelegate ()
@property(nonatomic, strong) TabBarController *tabController;
@property(nonatomic, strong) ReadMainViewController *readController;
@end

@implementation AppDelegate

-(TabBarController *)tabController{
    if (!_tabController) {
        _tabController = [[TabBarController alloc] init];
    }
    return _tabController;
}

-(ReadMainViewController *)readController{
    if (!_readController) {
        self.readController = [[ReadMainViewController alloc] init];
    }
    return _readController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self CheckState];
    if (!SexType) {
        [userdefault setValue:@"male" forKey:sexTypeKey];
        [userdefault synchronize];
    }

    return YES;
}

-(void)CheckState{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
//    if ([[ReadStateDefault sharedStateDefault] chooseReadState]) {
//        self.window.rootViewController = self.readController;
//    } else {
//        self.window.rootViewController = self.tabController;
//    }
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];
}


@end
