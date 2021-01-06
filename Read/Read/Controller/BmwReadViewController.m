
#import "BmwReadViewController.h"
#import "BmwCurrentReadController.h"
#import "BmwMenuView.h"
#import "BmwChapterModel.h"
#import "DZMCoverController.h"
#import "BmwConst_UI.h"
#import "MBProgressHUD.h"
#import "UIView+JZExtension.h"
#import "UIImage+ImageEffects.h"

@interface BmwReadViewController ()<BmwMenuViewDelegate,UIGestureRecognizerDelegate,DZMCoverControllerDelegate>
//自定义的翻页控制器(只支持混动，不支持翻页)
@property (nonatomic,strong) DZMCoverController *coverVC;
//菜单栏
@property (nonatomic, strong) BmwMenuView *menuView;
//当前阅读视图
@property (nonatomic, strong) BmwCurrentReadController *readView;
//将要变化的章节
@property (nonatomic, assign) NSUInteger chapterChange;
//将要变化的页数
@property (nonatomic, assign) NSUInteger pageChange;

@property (nonatomic, strong) BmwChapterModel *chapterModel;

@property (nonatomic, strong) NSMutableDictionary *preCaheModelDict;

@property (nonatomic, assign) NSInteger hadReadPage;

@property (nonatomic,strong) NSMutableArray *bookNameArray;

@end

@implementation BmwReadViewController

- (NSMutableArray *)bookNameArray{
    if (!_bookNameArray) {
        _bookNameArray = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"0", nil];
    }
    
    return _bookNameArray;
}

- (BmwChapterModel *)chapterModel{
    if (!_chapterModel) {
        _chapterModel = [[BmwChapterModel alloc] init];
    }
    return _chapterModel;
}

//- (void)viewWillAppear:(BOOL)animated{
//    self.navigationController.navigationBarHidden = YES;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    unsigned long encode =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    if (![self.bookNameArray containsObject:self.bookName]) {
        self.bookName = self.bookNameArray[arc4random_uniform(5)];
    }
    
     NSData *responseData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.bookName ofType:@"txt"]];
    
    NSString *mTxt = [[NSString alloc] initWithData:responseData encoding:encode];
    
    if (mTxt == nil) {
        
        mTxt = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:self.bookName ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    }
    
    self.chapterModel.content = mTxt;
    
    [self setupUI];
    
}

- (void)setupUI{
    [self addChildViewController:self.coverVC];
    [self.coverVC setController:self.readView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showToolMenu)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
    [self.view addSubview:self.menuView];
   
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _coverVC.view.frame = self.view.frame;
}

-(void)showToolMenu
{
    [self.menuView showAnimation:YES];
    [self.view bringSubviewToFront:self.menuView];
}

//解决TabView与Tap手势冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

#pragma mark menuViewDelegate
-(void)menuViewFontSize:(BmwBottomMenuView *)bottomMenu
{
    [self.chapterModel updateFont];
    self.readView = nil;
    [self.coverVC setController:self.readView];
}

- (void)menuViewJumpChapter:(BmwBottomMenuView *)bottomMenu isNextChapter:(BOOL)isNextChapter{
    
    
}

- (void)menuViewJumpChapter:(BmwBottomMenuView *)bottomMenu sliderValue:(float)sliderValue{
   
}

-(void)menuViewInvokeCatalog:(BmwBottomMenuView *)bottomMenu{
    
    
}

#pragma mark - DZMCoverControllerDelegate

// 切换结果
- (void)coverController:(DZMCoverController *)coverController currentController:(UIViewController *)currentController finish:(BOOL)isFinish{
    
}
// 上一个控制器
- (UIViewController *)coverController:(DZMCoverController *)coverController getAboveControllerWithCurrentController:(UIViewController *)currentController{
    self.readView = nil;
    if (_chapterChange == 1 &&_pageChange == 0) {
        return nil;
    }
    if (_pageChange ==0 ) {
        _chapterChange--;
    }
    else{
        _pageChange--;
    }
    
    return self.readView;
}

// 下一个控制器
- (UIViewController *)coverController:(DZMCoverController *)coverController getBelowControllerWithCurrentController:(UIViewController *)currentController{

    self.hadReadPage++;

    self.readView = nil;
    
    if (_pageChange == self.chapterModel.pageCount-1) {
        return nil;
    }
    if (_pageChange == self.chapterModel.pageCount-1) {
        _chapterChange++;
        _pageChange = 0;

    }
    else{
        _pageChange++;
    }
    return self.readView;
}
#pragma mark - init
-(BmwMenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[BmwMenuView alloc] initWithFrame:self.view.frame];
        _menuView.hidden = YES;
        _menuView.delegate = self;
        _menuView.chapterModel = self.chapterModel;
    }
    return _menuView;
}

- (DZMCoverController *)coverVC{
    if (!_coverVC) {
        _coverVC = [[DZMCoverController alloc] init];
        _coverVC.delegate = self;
        [self.view addSubview:_coverVC.view];
    }
    return _coverVC;
}

- (BmwCurrentReadController *)readView{
    if (!_readView) {
        _readView = [[BmwCurrentReadController alloc] init];
        _readView.content = [self.chapterModel stringOfPage:self.pageChange];
        self.chapterModel.page = self.pageChange;
        self.chapterModel.chapter = self.chapterChange;
        self.menuView.chapterModel = self.chapterModel;
    }
    return _readView;
}

- (NSMutableDictionary *)preCaheModelDict{
    if (!_preCaheModelDict) {
        _preCaheModelDict = [NSMutableDictionary dictionary];
    }
    return _preCaheModelDict;
}

@end
