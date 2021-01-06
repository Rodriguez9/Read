
#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BmwReadTool : NSObject<NSCoding>
+(instancetype)shareInstance;
@property (nonatomic) CGFloat fontSize;
@property (nonatomic) CGFloat lineSpace;
@property (nonatomic,strong) UIColor *fontColor;
@property (nonatomic,strong) UIColor *theme;
+(NSDictionary *)parserAttribute:(BmwReadTool *)config;
+(CTFrameRef)parserContent:(NSString *)content config:(BmwReadTool *)parser bouds:(CGRect)bounds;
@end

NS_ASSUME_NONNULL_END
