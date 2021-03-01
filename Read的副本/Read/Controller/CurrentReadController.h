
#import <UIKit/UIKit.h>
#import "ReadView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CurrentReadController : UIViewController

@property (nonatomic,strong) NSString *content; 

@property (nonatomic,strong) ReadView *readView;

@end

NS_ASSUME_NONNULL_END
