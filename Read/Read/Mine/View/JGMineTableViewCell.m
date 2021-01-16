

#import "JGMineTableViewCell.h"
#import <Masonry/Masonry.h>
@implementation JGMineTableViewCell

- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:16];
    }
    return _title;
}

- (UILabel *)detail{
    if (!_detail) {
        _detail = [[UILabel alloc] init];
        _detail.font = [UIFont systemFontOfSize:16];
    }
    return _detail;
}

- (UIImageView *)coverImg{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.contentMode = UIViewContentModeCenter;
        _coverImg.layer.cornerRadius = 5;
        _coverImg.clipsToBounds = YES;
        _coverImg.autoresizesSubviews = YES;
        _coverImg.backgroundColor = [UIColor blackColor];
    }
    return _coverImg;;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)configUI{
    
    [self.contentView addSubview:self.coverImg];
       [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.bottom.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
           make.width.mas_equalTo(50);
       }];
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).with.offset(5);
        make.centerY.equalTo(self.coverImg.mas_centerY);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.detail];
    [self.detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.title.mas_top);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(90);
    }];
   
}

@end
