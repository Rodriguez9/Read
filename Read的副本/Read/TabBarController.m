#import "TabBarController.h"
#import "RankViewController.h"
#import "NetWorkManager.h"
#import "PageViewController.h"
#import "Globe.h"
#import "APIS.h"
#import "Model.h"
#import <YYModel/YYModel.h>
#import "BoutiqueListController.h"
#import "BookshelfController.h"
#import "CategoryViewController.h"
@interface TabBarController ()
@property(nonatomic, strong) RankViewController *rankListController;
@property(nonatomic, strong) CategoryViewController *categoryController;
@property(nonatomic, strong) PageViewController *pageViewController;
@property(nonatomic, strong) BookshelfController *bookshelfController;
@property(nonatomic, strong) NSArray *titles;
@property(nonatomic, strong) NSMutableArray<RankViewController *> *ControllerList;
@property(nonatomic, strong) NSMutableArray<BoutiqueListController *> *BoutiqueList;

@end

@implementation TabBarController

-(PageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[PageViewController alloc] init:@[@"分类",@"排行榜"] vcs:@[self.categoryController,self.rankListController]];
    }
    return _pageViewController;
}

-(RankViewController *)rankListController{
    if (!_rankListController) {
        _rankListController = [[RankViewController alloc] init];
    }
    return _rankListController;
}

-(CategoryViewController *)categoryController{
    if (!_categoryController) {
        _categoryController = [[CategoryViewController alloc] init];
    }
    return _categoryController;
}

-(BookshelfController *)bookshelfController{

    if (!_bookshelfController) {
        _bookshelfController = [[BookshelfController alloc] init];
    }
    return _bookshelfController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tabBar setTranslucent:false];
    [self.tabBar setBarTintColor: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.99]];
     [self addChildViewController:self.pageViewController title:@"书籍" image:[UIImage imageNamed:@"tab_book"] selectdeImage:[UIImage imageNamed:@"tab_book_S"]];
    [self addChildViewController:self.bookshelfController title:@"书架" image:[UIImage imageNamed:@"tab_mine"] selectdeImage:[UIImage imageNamed:@"tab_mine_S"]];
    
    self.selectedViewController = [self.viewControllers objectAtIndex:0];;
}

-(void)addChildViewController:(UIViewController *)childController title: (NSString *)title image: (UIImage *)image selectdeImage:(UIImage *)selectdeImage {
    childController.title = title;
    childController.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                               image:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                                       selectedImage:[selectdeImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, 0, 0);
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childController];
    [nav.navigationBar setTitleTextAttributes: @{
        NSForegroundColorAttributeName : [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] colorWithAlphaComponent:1],
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
