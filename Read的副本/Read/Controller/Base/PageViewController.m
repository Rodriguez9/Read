
#import "PageViewController.h"
#import "HMSegmentedControl.h"
#import "Masonry.h"
#import "Globe.h"


@interface PageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@end

@implementation PageViewController

NSInteger currentSelectIndex;

-(HMSegmentedControl *)segment{
    if (!_segment) {
        _segment = [[HMSegmentedControl alloc] init];
        [_segment addTarget:self action:@selector(changeIndex:) forControlEvents:UIControlEventValueChanged];
        
        }
    _segment.verticalDividerEnabled = YES;
    _segment.verticalDividerColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.99];
    _segment.shouldAnimateUserSelection = true;
    _segment.selectionStyle = HMSegmentedControlSelectionStyleArrow;
    _segment.selectionIndicatorColor = [UIColor colorWithRed:30/255.0 green:144/255.0 blue:255/255.0 alpha:0.99];
    [_segment setTitleTextAttributes: @{
        NSForegroundColorAttributeName : [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] colorWithAlphaComponent:1],
        NSFontAttributeName : [UIFont systemFontOfSize:20],
    }];
    [_segment setSelectedTitleTextAttributes:@{
        NSForegroundColorAttributeName : [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] colorWithAlphaComponent:1],
        NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:25],
    }];
    return _segment;
}

-(UIView *)separate{
    if (!_separate) {
        _separate = [[UIView alloc] init];
        _separate.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.99];
    }
    return _separate;
}

-(UIPageViewController *)pageVC{
    if (!_pageVC) {
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    }
    _pageVC.delegate = self;
    _pageVC.dataSource = self;
    return _pageVC;
}

- (instancetype)init:(NSArray <NSString *>*)titles vcs:(NSArray <UIViewController *> *)vcs
{
    self = [super init];
    _titles = titles;
    _vcs = vcs;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)changeIndex:(UISegmentedControl *)segment{
    NSUInteger index = segment.selectedSegmentIndex;
    if (currentSelectIndex != index) {
        NSArray *targets = @[self.vcs[index]];
        int direction = currentSelectIndex > index? UIPageViewControllerNavigationDirectionReverse : UIPageViewControllerNavigationDirectionForward;
        [self.pageVC setViewControllers:targets direction:direction animated:false completion:^(BOOL finished) {
            currentSelectIndex = index;
        }];
    }
}

- (void)configUI{
    [super configUI];

    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    [self.pageVC setViewControllers:@[_vcs[0]] direction:UIPageViewControllerNavigationDirectionForward animated:false completion:nil];
    
    [self.view addSubview:self.segment];

    self.segment.backgroundColor = UIColor.clearColor;
    self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationNone;
    self.navigationItem.titleView = self.segment;
    self.segment.frame = CGRectMake(0, 0, ScreenWidth-120, 40);
    
    [self.pageVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    self.segment.sectionTitles = _titles;
    currentSelectIndex = 0;
    self.segment.selectedSegmentIndex = currentSelectIndex;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    NSInteger beforeIndex = [self.vcs indexOfObject:viewController]-1;
    if (beforeIndex < 0) {
        return nil;
    }
    return self.vcs[beforeIndex];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger afterIndex = [self.vcs indexOfObject:viewController]+1;
    if (afterIndex > self.vcs.count -1) {
           return nil;
       }
       return self.vcs[afterIndex];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    UIViewController *viewController = pageViewController.viewControllers.firstObject;
    NSInteger index = [self.vcs indexOfObject:viewController];
    currentSelectIndex = index;
    [self.segment setSelectedSegmentIndex:index animated:true];
    if (self.titles != nil) {
        self.navigationItem.title = self.titles[index];
    }
}


@end
