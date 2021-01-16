
#import "JGBoutiqueHeadCell.h"
#import <Masonry.h>

@implementation JGBoutiqueHeadCell
- (UILabel *)category{
    if (!_category) {
        _category = [[UILabel alloc] init];
        _category.textColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.99];
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

- (void)setModel:(JGCategoryModel *)model{
    self.model = model;
    self.category.text = [NSString stringWithFormat:@"%@%@",model.major,@">"];
}

@end
