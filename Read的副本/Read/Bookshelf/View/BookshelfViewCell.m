
#import "BookshelfViewCell.h"
#import <Masonry.h>
#import "APIS.h"
#import <SDWebImage.h>
@implementation BookshelfViewCell

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

-(UILabel *)shortIntroLabel
{
    if (!_shortIntroLabel) {
        _shortIntroLabel = [[UILabel alloc] init];
        _shortIntroLabel.font = [UIFont systemFontOfSize:13];
        _shortIntroLabel.textColor = [UIColor grayColor];
        _shortIntroLabel.numberOfLines = 4;
        _shortIntroLabel.textAlignment = NSTextAlignmentLeft;
        [_shortIntroLabel sizeToFit];
    }
    return _shortIntroLabel;
}


-(void)configUI{
    
    self.clipsToBounds = YES;
    self.contentView.layer.cornerRadius = 5.0;
    
    [self.contentView addSubview:self.coverImg];
    
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.width.mas_equalTo(80);
    }];
    
    [self.contentView addSubview:self.bookName];
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).with.offset(10);
        make.top.equalTo(self.coverImg.mas_top);
        make.right.equalTo(self.contentView).offset(-50);
        make.height.mas_equalTo(15);
    }];
    
    [self.contentView addSubview:self.shortIntroLabel];
    [self.shortIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookName.mas_left);
        make.top.equalTo(self.bookName.mas_bottom);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.coverImg.mas_bottom);
    }];
    
   
}
- (void)setBook:(NSDictionary *)book{
    _book = book;
    self.bookName.text = [book valueForKey:@"bookName"];
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,[book valueForKey:@"cover"]]]];
    self.shortIntroLabel.text = [book valueForKey:@"shortIntro"];
}

@end
