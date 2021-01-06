//
//  AppDelegate.m
//  Read
//
//  Created by Jarvis on 2020/12/11.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TabBarController.h"
#import "APIS.h"
@interface AppDelegate ()
@property(nonatomic, strong) TabBarController *tabController;
@end

@implementation AppDelegate

-(TabBarController *)tabController{
    if (!_tabController) {
        _tabController = [[TabBarController alloc] init];
    }
    return _tabController;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabController;
    [self.window makeKeyAndVisible];

    return YES;
}


@end
