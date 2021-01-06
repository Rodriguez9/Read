

#import <UIKit/UIKit.h>
#import "BmwTopMenuView.h"
#import "BmwBottomMenuView.h"
#import "BmwChapterModel.h"

NS_ASSUME_NONNULL_BEGIN

@class BmwMenuView;
@protocol BmwMenuViewDelegate <NSObject>
@optional
-(void)menuViewDidHidden:(BmwMenuView *)menu;
-(void)menuViewDidAppear:(BmwMenuView *)menu;
-(void)menuViewInvokeCatalog:(BmwBottomMenuView *)bottomMenu;
-(void)menuViewJumpChapter:(BmwBottomMenuView *)bottomMenu isNextChapter:(BOOL)isNextChapter;
-(void)menuViewJumpChapter:(BmwBottomMenuView *)bottomMenu sliderValue:(float)sliderValue;
-(void)menuViewFontSize:(BmwBottomMenuView *)bottomMenu;
//-(void)menuViewMark:(LSYTopMenuView *)topMenu;
@end

@interface BmwMenuView : UIView
@property (nonatomic,weak) id<BmwMenuViewDelegate>delegate;
@property (nonatomic, strong) BmwTopMenuView *topView;
@property (nonatomic, strong) BmwBottomMenuView *bottomView;
@property (nonatomic, strong) BmwChapterModel *chapterModel;
-(void)showAnimation:(BOOL)animation;
-(void)hiddenAnimation:(BOOL)animation;
@end

NS_ASSUME_NONNULL_END
