
#import "BoutiqueHeadCell.h"
#import <Masonry.h>

@implementation BoutiqueHeadCell
- (UILabel *)category{
    if (!_category) {
        _category = [[UILabel alloc] init];
        _category.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.99];
        [_category setFont:[UIFont fontWithName:@"Helvetica-Bold" size:30]];
    }
    return _category;
}

-(void)configUI{
    self.layer.cornerRadius = 15;
    [self addSubview:self.category];
    [self.category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.left.right.equalTo(self).offset(5);
    }];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)setModel:(CategoryModel *)model{
    self.model = model;
    self.category.text = [NSString stringWithFormat:@"%@%@",model.major,@">"];
}

@end
