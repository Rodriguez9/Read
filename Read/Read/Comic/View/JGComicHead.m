#import "JGComicHead.h"
#import "APIS.h"
#import <Masonry.h>

@implementation JGComicHead

-(UIImageView *)coverImg{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.contentMode = UIViewContentModeScaleAspectFill;
        _coverImg.layer.cornerRadius = 5;
        _coverImg.clipsToBounds = YES;
        _coverImg.autoresizesSubviews = YES;
    }
    return _coverImg;;
}



-(UILabel *)bookName
{
    if (!_bookName) {
        _bookName = [[UILabel alloc] init];
        _bookName.textColor = [UIColor whiteColor];
        _bookName.font = [UIFont systemFontOfSize:20];
    }
    return _bookName;
}

-(UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:15];
        _authorLabel.textColor = [UIColor whiteColor];
       
    }
    return _authorLabel;
}

-(UILabel *)majorCate
{
    if (!_majorCate) {
        _majorCate = [[UILabel alloc] init];
        _majorCate.font = [UIFont systemFontOfSize:16];
        _majorCate.textColor = [UIColor orangeColor];
        _majorCate.layer.borderColor = [[UIColor colorWithRed:238/255.0 green:232/255.0 blue:200/255.0 alpha:0.99] CGColor];
         [_majorCate setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    }
    return _majorCate;
}

-(UILabel *)minorCate
{
    if (!_minorCate) {
        _minorCate = [[UILabel alloc] init];
        _minorCate.font = [UIFont systemFontOfSize:16];
        _minorCate.textColor = [UIColor greenColor];
        _minorCate.layer.borderColor = [[UIColor colorWithRed:240/255.0 green:255/255.0 blue:250/255.0 alpha:0.99] CGColor];
        [_minorCate setFont:[UIFont fontWithName:@"Helvetica-Bold" size:10]];
    }
    return _minorCate;
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
                       author:(NSString*)author
                        major:(NSString*)major
                        minor:(NSString*)minor
{
    self = [super init];
    if (self) {
        self.coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,cover]]]];
        self.bookName.text = bookName;
        self.authorLabel.text = author;
        self.majorCate.text = major;
        self.minorCate.text = minor;
        [self configUI];
    }
    return self;
}

-(void)configUI{
    
    [self addSubview:self.coverImg];
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self).insets(UIEdgeInsetsMake(10, 10, 20, 10));
        make.width.mas_equalTo(100);
    }];
    
    
    [self addSubview:self.bookName];
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).with.offset(10);
        make.top.equalTo(self.coverImg.mas_top);
        make.right.equalTo(self).offset(-50);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.authorLabel];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).with.offset(10);
        make.top.equalTo(self.bookName.mas_bottom).with.offset(2);
         make.right.equalTo(self).offset(-50);
        make.height.mas_equalTo(25);
    }];
    
    [self addSubview:self.majorCate];
    [self.majorCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorLabel.mas_left);
        make.top.equalTo(self.authorLabel.mas_bottom).with.offset(2);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];

    [self addSubview:self.minorCate];
    [self.minorCate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.majorCate.mas_left);
        make.top.equalTo(self.majorCate.mas_bottom).with.offset(2);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(25);
    }];
    

    
    [self addSubview:self.shortIntroLabel];
    [self.shortIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookName.mas_left);
        make.top.equalTo(self.authorLabel.mas_bottom).with.offset(5);
        make.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
    }];
    
}

@end
