//
//  UIImage+Blur.h
//  Read
//
//  Created by Jarvis on 2021/1/5.
//  Copyright © 2021 Jarvis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Blur)
- (UIImage*)blurredImage:(CGFloat)blurAmount;
@end

NS_ASSUME_NONNULL_END
