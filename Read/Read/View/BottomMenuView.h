

#import <UIKit/UIKit.h>
#import "ChapterModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MenuViewDelegate;

@interface BottomMenuView : UIView
@property (nonatomic,weak)id<MenuViewDelegate>delegate;
@property (nonatomic, strong) ChapterModel *chapterModel;
@end

NS_ASSUME_NONNULL_END
