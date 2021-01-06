
#import <UIKit/UIKit.h>
#import "BmwReadView.h"

NS_ASSUME_NONNULL_BEGIN

@interface BmwCurrentReadController : UIViewController

@property (nonatomic,strong) NSString *content; //显示的内容

@property (nonatomic,strong) BmwReadView *readView;

@end

NS_ASSUME_NONNULL_END
