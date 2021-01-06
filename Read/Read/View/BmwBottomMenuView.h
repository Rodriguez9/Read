

#import <UIKit/UIKit.h>
#import "BmwChapterModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol BmwMenuViewDelegate;

@interface BmwBottomMenuView : UIView
@property (nonatomic,weak)id<BmwMenuViewDelegate>delegate;
@property (nonatomic, strong) BmwChapterModel *chapterModel;
@end

NS_ASSUME_NONNULL_END
