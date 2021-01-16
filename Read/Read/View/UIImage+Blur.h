#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Blur)
- (UIImage*)blurredImage:(CGFloat)blurAmount;
@end

NS_ASSUME_NONNULL_END
