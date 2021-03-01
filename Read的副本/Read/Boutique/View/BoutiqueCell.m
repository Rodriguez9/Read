
#import "BoutiqueCell.h"
#import <Masonry.h>
#import "APIS.h"
#import "Globe.h"
#import <SDWebImage.h>

@implementation BoutiqueCell

-(UIImageView *)coverImg{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.layer.cornerRadius = 5;
        _coverImg.autoresizesSubviews = YES;
    }
    return _coverImg;;
}

-(UILabel *)bookName
{
    if (!_bookName) {
        _bookName = [[UILabel alloc] init];
        _bookName.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.99];
        _bookName.font = [UIFont systemFontOfSize:16];
    }
    return _bookName;
}

-(UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc] init];
        _desLabel.font = [UIFont systemFontOfSize:13];
        _desLabel.textColor = [UIColor lightGrayColor];
        _desLabel.numberOfLines = 4;
        
    }
    return _desLabel;
}



-(void)configUI{
    
    self.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
    
    
    self.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
    
    [self.contentView addSubview:self.coverImg];
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 0, 0, 5));
        make.width.mas_equalTo(floor((ScreenWidth - 40.0)/4.0));
    }];
    
    [self.contentView addSubview:self.bookName];
        [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.coverImg.mas_right).with.offset(10);
            make.right.equalTo(self.contentView).with.offset(-10);
            make.top.equalTo(self.coverImg.mas_top).with.offset(5);
            make.height.mas_equalTo(20);
        }];
    
    [self.contentView addSubview:self.desLabel];
        [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bookName.mas_left);
            make.right.equalTo(self.bookName.mas_right);
            make.top.equalTo(self.bookName.mas_bottom);
            make.bottom.equalTo(self.contentView).with.offset(-5);
        }];
}

- (void)setModel:(BookModel *)model{
    _model = model;
    self.bookName.text = self.model.title;
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,model.cover]]];
    self.desLabel.text = self.model.shortIntro;
}

@end
