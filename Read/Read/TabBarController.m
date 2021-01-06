//
//  TabBarController.m
//  Read
//
//  Created by Jarvis on 2020/12/25.
//  Copyright © 2020 Jarvis. All rights reserved.
//

#import "TabBarController.h"
#import "RankListViewController.h"
#import "NetWorkManager.h"
#import "Globe.h"
#import "APIS.h"
#import "CategoryModel.h"
#import <YYModel/YYModel.h>
#import "ViewController.h"
#import "MineViewController.h"
#import "BoutiqueListController.h"
@interface TabBarController ()
@property(nonatomic, strong) RankListViewController *rankListController;
@property(nonatomic, strong) MainViewController *boutiqueController;
@property(nonatomic, strong) MineViewController *mineController;

@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) NSMutableArray<RankListViewController *> *ControllerList;
@property(nonatomic, strong) NSMutableArray<BoutiqueListController *> *BoutiqueList;

@end

@implementation TabBarController

-(NSArray *)titles{
    _titles = [NSArray array];
    _titles = @[@"玄幻",@"奇幻",@"武侠",@"仙侠",@"都市",@"悬疑",@"少儿"];
    return _titles;
}

-(NSMutableArray<BoutiqueListController *> *)BoutiqueList{
    _BoutiqueList = [NSMutableArray<BoutiqueListController *> array];
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BoutiqueListController *Boutiquelist = [[BoutiqueListController alloc] init:obj];
        [_BoutiqueList addObject:Boutiquelist];
    }];
    return _BoutiqueList;
}

-(RankListViewController *)rankListController{
    if (!_rankListController) {
        _rankListController = [[RankListViewController alloc] init];
    }
    return _rankListController;
}

-(MineViewController *)mineController{

    if (!_mineController) {
        _mineController = [[MineViewController alloc] init];
    }
    return _mineController;
}

-(MainViewController *)boutiqueController{
    if (!_boutiqueController) {
        self.boutiqueController = [[MainViewController alloc] init:self.titles vcs:self.BoutiqueList];
    }
    return _boutiqueController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTranslucent:false];
    [self.tabBar setBarTintColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.99]];

     [self addChildViewController:self.boutiqueController title:@"首页" image:[UIImage imageNamed:@"tab_home"] selectdeImage:[UIImage imageNamed:@"tab_home_S"]];
     [self addChildViewController:self.rankListController title:@"排行榜" image:[UIImage imageNamed:@"tab_book"] selectdeImage:[UIImage imageNamed:@"tab_book_S"]];
    [self addChildViewController:self.mineController title:@"我的" image:[UIImage imageNamed:@"tab_mine"] selectdeImage:[UIImage imageNamed:@"tab_mine_S"]];
    self.selectedViewController = [self.viewControllers objectAtIndex:0];;
}

-(void)addChildViewController:(UIViewController *)childController title: (NSString *)title image: (UIImage *)image selectdeImage:(UIImage *)selectdeImage {
    childController.title = title;
    childController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                               image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[selectdeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    nav.navigationBar.barTintColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.99];
    [nav.navigationBar setTitleTextAttributes: @{
        NSForegroundColorAttributeName : [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] colorWithAlphaComponent:0.5],
        NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:25], 
    }];
    nav.navigationBar.translucent = YES;
    [self addChildViewController:nav];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    UIViewController *select = [self selectedViewController];
    if (select) {
        return select.preferredScreenEdgesDeferringSystemGestures;
    } else {
        return UIStatusBarStyleDarkContent;
    }
}






@end
