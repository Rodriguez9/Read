
#import <UIKit/UIKit.h>

@interface UIView (JZExtension)

/** 在分类中声明@property, 只会生成方法（get,set）的声明, 不会生成方法的实现和带有_下划线的成员变量*/

/** x */
@property (nonatomic, assign) CGFloat jz_x;
/** y */
@property (nonatomic, assign) CGFloat jz_y;
/** 宽度 */
@property (nonatomic, assign) CGFloat jz_width;
/** 高度 */
@property (nonatomic, assign) CGFloat jz_height;
/** 原点 */
@property (nonatomic, assign) CGPoint jz_origin;
/** 尺寸 */
@property (nonatomic, assign) CGSize jz_size;
/** 中心点x */
@property (nonatomic, assign) CGFloat jz_centerX;
/** 中心点y */
@property (nonatomic, assign) CGFloat jz_centerY;

@end
