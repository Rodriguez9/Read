#import "JGBoutiqueViewCell.h"
#import <Masonry.h>
#import "APIS.h"

@implementation JGBoutiqueViewCell

-(UIImageView *)coverImg{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.contentMode = UIViewContentModeScaleAspectFill;
        _coverImg.layer.cornerRadius = 5;
        _coverImg.clipsToBounds = YES;
        _coverImg.autoresizesSubviews = YES;
        _coverImg.backgroundColor = [UIColor blackColor];
    }
    return _coverImg;;
}

-(UILabel *)bookName
{
    if (!_bookName) {
        _bookName = [[UILabel alloc] init];
        _bookName.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.99];
        _bookName.font = [UIFont systemFontOfSize:10];
    }
    return _bookName;
}


-(void)configUI{
    
    self.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
    
    [self.contentView addSubview:self.bookName];
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).with.offset(5);
        make.height.mas_equalTo(25);
        make.bottom.equalTo(self.contentView);
    }];
    
    [self.contentView addSubview:self.coverImg];
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.bookName.mas_top).offset(-5);
    }];
    
   
}

- (void)setModel:(JGBookModel *)model{
    _model = model;
    self.bookName.text = self.model.title;
     self.coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,model.cover]]]];
}

@end
