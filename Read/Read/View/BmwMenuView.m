
#import "BmwMenuView.h"
#import "UIView+JZExtension.h"
#import "BmwConst_UI.h"

@interface BmwMenuView()<BmwMenuViewDelegate>

@end

@implementation BmwMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenSelf)]];
}

- (void)setChapterModel:(BmwChapterModel *)chapterModel{
    _chapterModel = chapterModel;
    self.bottomView.chapterModel = chapterModel;
}
-(void)hiddenSelf
{
    [self hiddenAnimation:YES];
}

-(void)showAnimation:(BOOL)animation
{
    self.hidden = NO;
    [UIView animateWithDuration:animation?0.3:0 animations:^{
        self.topView.frame = CGRectMake(0, 0, self.jz_width, HEIGHT_NAV_FIT);
        self.bottomView.frame = CGRectMake(0, self.jz_height - 200, self.jz_width,200);
    } completion:^(BOOL finished) {
        
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewDidAppear:)]) {
        [self.delegate menuViewDidAppear:self];
    }
}

-(void)hiddenAnimation:(BOOL)animation
{
    
    [UIView animateWithDuration:animation?0.3:0 animations:^{
        self.topView.frame = CGRectMake(0, -HEIGHT_NAV_FIT, self.jz_width, HEIGHT_NAV_FIT);
        self.bottomView.frame = CGRectMake(0, self.jz_height, self.jz_width,200);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    if ([self.delegate respondsToSelector:@selector(menuViewDidHidden:)]) {
        [self.delegate menuViewDidHidden:self];
    }
}

-(void)menuViewFontSize:(BmwBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewFontSize:)]) {
        [self.delegate menuViewFontSize:bottomMenu];
    }
}

- (void)menuViewJumpChapter:(BmwBottomMenuView *)bottomMenu isNextChapter:(BOOL)isNextChapter{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:isNextChapter:)]) {
        [self.delegate menuViewJumpChapter:bottomMenu isNextChapter:isNextChapter];
    }
}

-(void)menuViewInvokeCatalog:(BmwBottomMenuView *)bottomMenu
{
    if ([self.delegate respondsToSelector:@selector(menuViewInvokeCatalog:)]) {
        [self.delegate menuViewInvokeCatalog:bottomMenu];
    }
}

- (void)menuViewJumpChapter:(BmwBottomMenuView *)bottomMenu sliderValue:(float)sliderValue{
    if ([self.delegate respondsToSelector:@selector(menuViewJumpChapter:sliderValue:)]) {
        [self.delegate menuViewJumpChapter:bottomMenu sliderValue:sliderValue];
    }
}
-(BmwTopMenuView *)topView
{
    if (!_topView) {
        _topView = [[BmwTopMenuView alloc] initWithFrame:CGRectMake(0, -HEIGHT_NAV_FIT,self.jz_width,HEIGHT_NAV_FIT)];
        _topView.delegate = self;
    }
    return _topView;
}

-(BmwBottomMenuView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BmwBottomMenuView alloc] initWithFrame:CGRectMake(0, self.jz_height, self.jz_width,200)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
@end
