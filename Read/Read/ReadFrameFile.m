#import "ReadFrameFile.h"
#import "Globe.h"
@implementation ReadFrameFile


+ (CGFloat)ReadORX{
    
    CGFloat oringX = 0;
    
    UIInterfaceOrientation ReadCurrentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (ReadCurrentOrientation == UIInterfaceOrientationLandscapeLeft || ReadCurrentOrientation == UIInterfaceOrientationLandscapeRight) {
        if (SCREEN_SIZE_WIDTH == 812 || SCREEN_SIZE_WIDTH == 896 ||SCREEN_SIZE_WIDTH == 844 || SCREEN_SIZE_WIDTH == 926) {
            oringX = 34;
        }
    }
    
    return oringX;
}

+ (CGFloat)ReadORY{
    
    CGFloat oringY = 0;
    
    UIInterfaceOrientation ReadCurrentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (ReadCurrentOrientation == UIInterfaceOrientationPortrait) {
        if (SCREEN_SIZE_HEIGHT == 812 || SCREEN_SIZE_HEIGHT == 896  || SCREEN_SIZE_HEIGHT == 844  || SCREEN_SIZE_HEIGHT == 926) {
            oringY = 34;
        }
    }
    
    return oringY;
    
}

+ (CGFloat)ReadHTX{
    
    CGFloat width = SCREEN_SIZE_WIDTH;
    
    UIInterfaceOrientation ReadCurrentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (ReadCurrentOrientation == UIInterfaceOrientationLandscapeLeft || ReadCurrentOrientation == UIInterfaceOrientationLandscapeRight) {
        if (SCREEN_SIZE_WIDTH == 812 || SCREEN_SIZE_WIDTH == 896 || SCREEN_SIZE_WIDTH == 844 || SCREEN_SIZE_WIDTH == 926) {
            width = SCREEN_SIZE_WIDTH - 34 - 34;
        }
    }
    
    return width;
    
}

+ (CGFloat)ReadHTY{
    
    CGFloat height = SCREEN_SIZE_HEIGHT;
    
    UIInterfaceOrientation ReadCurrentOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if (ReadCurrentOrientation == UIInterfaceOrientationPortrait) {
        if (SCREEN_SIZE_HEIGHT == 812 || SCREEN_SIZE_HEIGHT == 896 || SCREEN_SIZE_HEIGHT == 844 || SCREEN_SIZE_HEIGHT == 926) {
            height = SCREEN_SIZE_HEIGHT - 34 - 34;
        }
    }
    
    return height;
    
}
@end
