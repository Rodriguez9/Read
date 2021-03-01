
#import "RankHeadView.h"
#import <Masonry/Masonry.h>
#import "APIS.h"
@implementation RankHeadView

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
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-5);
        make.left.equalTo(self.contentView).offset(15);
    }];
    
   
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
        self.contentView.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setModel:(RankTypeModel *)model{
    _model = model;
    self.category.text = model.title;
}

@end
