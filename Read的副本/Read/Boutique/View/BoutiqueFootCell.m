#import "BoutiqueFootCell.h"
#import "UIView+rd_wid.h"
#import "Globe.h"
@implementation BoutiqueFootCell

-(UIButton *)all{
    if (!_all) {
        _all = [[UIButton alloc] init];
        [_all setTitle:@"查看全部" forState:UIControlStateNormal];
        _all.titleLabel.font = [UIFont systemFontOfSize:15];
        [_all setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [_all addTarget:self action:@selector(allBookClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _all;
}

-(UIView *)bottomSeparate
{
    if (!_bottomSeparate) {
        _bottomSeparate = [[UIView alloc] init];
        _bottomSeparate.backgroundColor = UIColor.whiteColor;
    }
    return _bottomSeparate;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.all.frame = CGRectMake(0, 0, self.width, self.height-5);
    self.bottomSeparate.frame = CGRectMake(0, 0, self.width, 1);
    self.bottomSeparate.bottom = self.height;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.all];
        [self addSubview:self.updateButton];
        [self addSubview:self.seprate];
        [self addSubview:self.bottomSeparate];
    }
    return self;
}

- (void)setAllbook:(void (^)(void))Allbook{
    _Allbook = Allbook;
}

-(void)allBookClick{
    self.Allbook();
}

@end
