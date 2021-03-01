

#import "CategoryViewCell.h"
#import <Masonry.h>
#import "APIS.h"
#import <SDWebImage.h>
@implementation CategoryViewCell

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
        _bookName.font = [UIFont systemFontOfSize:20];
        _bookName.textAlignment = NSTextAlignmentCenter;
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
        make.top.equalTo(self.contentView).with.offset(10);
        make.left.right.equalTo(self.contentView).with.offset(1);
        make.bottom.equalTo(self.bookName.mas_top).offset(-1);
    }];
    
   
}

- (void)setModel:(Model *)model{
    _model = model;
    self.bookName.text = self.model.name;
    [self.coverImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,model.bookCover[0]]]];
}

@end
