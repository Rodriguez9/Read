

#import <UIKit/UIKit.h>
#import "TopMenuView.h"
#import "BottomMenuView.h"
#import "ChapterModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MenuView;
@protocol MenuViewDelegate <NSObject>
@optional
-(void)menuViewDidHidden:(MenuView *)menu;
-(void)menuViewDidAppear:(MenuView *)menu;
-(void)menuViewInvokeCatalog:(BottomMenuView *)bottomMenu;
-(void)menuViewJumpChapter:(BottomMenuView *)bottomMenu isNextChapter:(BOOL)isNextChapter;
-(void)menuViewJumpChapter:(BottomMenuView *)bottomMenu sliderValue:(float)sliderValue;
-(void)menuViewFontSize:(BottomMenuView *)bottomMenu;
//-(void)menuViewMark:(LSYTopMenuView *)topMenu;
@end

@interface MenuView : UIView
@property (nonatomic,weak) id<MenuViewDelegate>delegate;
@property (nonatomic, strong) TopMenuView *topView;
@property (nonatomic, strong) BottomMenuView *bottomView;
@property (nonatomic, strong) ChapterModel *chapterModel;
-(void)showAnimation:(BOOL)animation;
-(void)hiddenAnimation:(BOOL)animation;
@end

NS_ASSUME_NONNULL_END
