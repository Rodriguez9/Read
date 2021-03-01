

#import "AppDelegate.h"
#import "TabBarController.h"
#import "APIS.h"
#import "Globe.h"
#import "ReadStateDefault.h"
#import "ReadController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self CheckState];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noticeCallback:) name:bookshelfKey object:nil];

    return YES;
}

-(void)noticeCallback:(NSNotification*)notification{
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:[userdefault valueForKey:bookshelfKey]];
    if ([arr containsObject:notification.userInfo[@"book"]]==NO) {
        [arr addObject:notification.userInfo[@"book"]];
    }
    [userdefault setValue:arr forKey:bookshelfKey];
}

-(void)CheckState{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if ([[ReadStateDefault sharedStateDefault] chooseReadState]) {
        self.window.rootViewController = [[ReadController alloc] init];
    } else {
        self.window.rootViewController = [[TabBarController alloc] init];
    }
    [self.window makeKeyAndVisible];
}


@end
