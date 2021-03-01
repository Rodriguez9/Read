#import "ComicHead.h"
#import "APIS.h"
#import <Masonry.h>

@implementation ComicHead

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
        _bookName.textColor = [UIColor blackColor];
        _bookName.font = [UIFont systemFontOfSize:20];
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


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)init:(NSString*)bookName
                        coverImg:(NSString*)cover
                    shortIntro:(NSString*)shortIntro
{
    self = [super init];
    if (self) {
        self.coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,cover]]]];
        self.bookName.text = bookName;
        self.shortIntroLabel.text = shortIntro;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    [self addSubview:self.coverImg];
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(100);
    }];
    
    
    [self addSubview:self.bookName];
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).with.offset(10);
        make.top.equalTo(self.coverImg.mas_top);
        make.right.equalTo(self).offset(-50);
        make.height.mas_equalTo(30);
    }];
    
    
    [self addSubview:self.shortIntroLabel];
    [self.shortIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bookName.mas_bottom).with.offset(5);
        make.bottom.equalTo(self.coverImg.mas_bottom);
        make.left.equalTo(self.bookName.mas_left);
        make.right.equalTo(self);
    }];
}

@end
