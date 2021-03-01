
#import "ReadViewController.h"
#import "CurrentReadController.h"
#import "MenuView.h"
#import "ChapterModel.h"
#import "CoverController.h"
#import "Const_UI.h"
#import "MBProgressHUD.h"
#import "UIView+JZExtension.h"
#import "UIImage+ImageEffects.h"

@interface ReadViewController ()<MenuViewDelegate,UIGestureRecognizerDelegate,CoverControllerDelegate>
//自定义的翻页控制器(只支持混动，不支持翻页)
@property (nonatomic,strong) CoverController *coverVC;
//菜单栏
@property (nonatomic, strong) MenuView *menuView;
//当前阅读视图
@property (nonatomic, strong) CurrentReadController *readView;
//将要变化的章节
@property (nonatomic, assign) NSUInteger chapterChange;
//将要变化的页数
@property (nonatomic, assign) NSUInteger pageChange;

@property (nonatomic, strong) ChapterModel *chapterModel;

@property (nonatomic, strong) NSMutableDictionary *preCaheModelDict;

@property (nonatomic, assign) NSInteger hadReadPage;

@property (nonatomic,strong) NSMutableArray *bookNameArray;

@end

@implementation ReadViewController

- (NSMutableArray *)bookNameArray{
    if (!_bookNameArray) {
        _bookNameArray = [NSMutableArray arrayWithObjects:@"至尊毒妃邪王的盛宠娇妃",@"富贵小丫鬟",@"丑女神医农门太子妃",@"穿书后嫁给前夫他舅舅",@"废柴嫡女要翻天",@"神医魔后不好惹",@"兽黑狂妃皇叔逆天宠",@"团宠公主三岁半",@"王的女人谁敢动",@"邪帝的神医弃妃",@"元后传",@"至尊毒妃邪王的盛宠娇妃", nil];
    }
    
    return _bookNameArray;
}

- (ChapterModel *)chapterModel{
    if (!_chapterModel) {
        _chapterModel = [[ChapterModel alloc] init];
    }
    return _chapterModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    unsigned long encode =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    
    if (![self.bookNameArray containsObject:self.bookName]) {
        self.bookName = self.bookNameArray[arc4random_uniform(12)];
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
-(void)menuViewFontSize:(BottomMenuView *)bottomMenu
{
    [self.chapterModel updateFont];
    self.readView = nil;
    [self.coverVC setController:self.readView];
}

- (void)menuViewJumpChapter:(BottomMenuView *)bottomMenu isNextChapter:(BOOL)isNextChapter{
    
    
}

- (void)menuViewJumpChapter:(BottomMenuView *)bottomMenu sliderValue:(float)sliderValue{
   
}

-(void)menuViewInvokeCatalog:(BottomMenuView *)bottomMenu{
    
    
}

#pragma mark - CoverControllerDelegate

// 切换结果
- (void)coverController:(CoverController *)coverController currentController:(UIViewController *)currentController finish:(BOOL)isFinish{
    
}
// 上一个控制器
- (UIViewController *)coverController:(CoverController *)coverController getAboveControllerWithCurrentController:(UIViewController *)currentController{
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
- (UIViewController *)coverController:(CoverController *)coverController getBelowControllerWithCurrentController:(UIViewController *)currentController{

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
-(MenuView *)menuView
{
    if (!_menuView) {
        _menuView = [[MenuView alloc] initWithFrame:self.view.frame];
        _menuView.hidden = YES;
        _menuView.delegate = self;
        _menuView.chapterModel = self.chapterModel;
    }
    return _menuView;
}

- (CoverController *)coverVC{
    if (!_coverVC) {
        _coverVC = [[CoverController alloc] init];
        _coverVC.delegate = self;
        [self.view addSubview:_coverVC.view];
    }
    return _coverVC;
}

- (CurrentReadController *)readView{
    if (!_readView) {
        _readView = [[CurrentReadController alloc] init];
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
