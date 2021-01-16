#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReadStateDefault : NSObject
+ (ReadStateDefault *)sharedStateDefault;

- (BOOL)chooseReadState;
@end

NS_ASSUME_NONNULL_END
