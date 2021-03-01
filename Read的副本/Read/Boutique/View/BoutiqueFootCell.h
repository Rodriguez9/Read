#import <UIKit/UIKit.h>
#import <Masonry.h>

NS_ASSUME_NONNULL_BEGIN

@interface BoutiqueFootCell : UICollectionReusableView
@property (nonatomic,strong) UIButton *all;
@property (nonatomic,strong) UIView *seprate;
@property (nonatomic,strong) UIButton *updateButton;
@property (nonatomic,strong) UIView *bottomSeparate;
@property(nonatomic,copy) void(^Allbook)(void);
@end

NS_ASSUME_NONNULL_END
