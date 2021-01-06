

#import "UIView+JZExtension.h"

@implementation UIView (JZExtension)

- (CGFloat)jz_x
{
    return self.frame.origin.x;
}

- (CGFloat)jz_y
{
    return self.frame.origin.y;
}

- (CGFloat)jz_centerX
{
    return self.center.x;
}

- (CGFloat)jz_centerY
{
    return self.center.y;
}

- (CGFloat)jz_width
{
    return self.frame.size.width;
}

- (CGFloat)jz_height
{
    return self.frame.size.height;
}

- (CGPoint)jz_origin
{
    return self.frame.origin;
}

- (CGSize)jz_size
{
    return self.frame.size;
}


#pragma mark -


- (void)setJz_x:(CGFloat)jz_x
{
    CGRect r = self.frame;
    r.origin.x = jz_x;
    self.frame = r;
}
- (void)setJz_y:(CGFloat)jz_y
{
    CGRect r = self.frame;
    r.origin.y = jz_y;
    self.frame = r;
}
- (void)setJz_centerX:(CGFloat)jz_centerX
{
    CGPoint center = self.center;
    center.x = jz_centerX;
    self.center = center;
}
- (void)setJz_centerY:(CGFloat)jz_centerY
{
    CGPoint center = self.center;
    center.y = jz_centerY;
    self.center = center;
}
- (void)setJz_width:(CGFloat)jz_width
{
    CGRect r = self.frame;
    r.size.width = jz_width;
    self.frame = r;
}
- (void)setJz_height:(CGFloat)jz_height
{
    CGRect r = self.frame;
    r.size.height = jz_height;
    self.frame = r;
}

- (void)setJz_origin:(CGPoint)jz_origin
{
    CGRect r = self.frame;
    r.origin = jz_origin;
    self.frame = r;
}

- (void)setJz_size:(CGSize)jz_size
{
    CGRect r = self.frame;
    r.size = jz_size;
    self.frame = r;
}

@end
