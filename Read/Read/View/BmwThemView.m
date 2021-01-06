
#import "BmwThemView.h"
#import "BmwConst_UI.h"
#import "UIView+JZExtension.h"

@interface BmwThemView()
@property (nonatomic,strong) UIView *theme1;
@property (nonatomic,strong) UIView *theme2;
@property (nonatomic,strong) UIView *theme3;
@end

@implementation BmwThemView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.theme1];
    [self addSubview:self.theme2];
    [self addSubview:self.theme3];
}

-(UIView *)theme1
{
    if (!_theme1) {
        _theme1 = [[UIView alloc] init];
        _theme1.backgroundColor = BmwColor(248, 218, 138,1.0);
        _theme1.layer.cornerRadius = 20;
        [_theme1 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
    }
    return _theme1;
}
-(UIView *)theme2
{
    if (!_theme2) {
        _theme2 = [[UIView alloc] init];
         _theme2.layer.cornerRadius = 20;
        _theme2.backgroundColor = BmwColor(188, 178, 190,1.0);
        [_theme2 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
    }
    return _theme2;
}
-(UIView *)theme3
{
    if (!_theme3) {
        _theme3 = [[UIView alloc] init];
         _theme3.layer.cornerRadius = 20;
        _theme3.backgroundColor = [UIColor whiteColor];
        [_theme3 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeTheme:)]];
    }
    return _theme3;
}
-(void)changeTheme:(UITapGestureRecognizer *)tap
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BmwThemeNotification" object:tap.view.backgroundColor];
}
-(void)layoutSubviews
{
    CGFloat spacing = (self.jz_width - 40*3)/4;
    _theme1.frame = CGRectMake(spacing, 0, 40, 40);
    _theme2.frame = CGRectMake(self.theme1.jz_origin.x + self.theme1.jz_width + spacing, 0, 40, 40);
    _theme3.frame = CGRectMake(self.theme2.jz_origin.x + self.theme2.jz_width + spacing, 0, 40, 40);
}
@end
