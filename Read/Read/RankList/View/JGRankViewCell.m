

#import "JGRankViewCell.h"
#import "APIS.h"

@implementation JGRankViewCell

-(UIImageView *)coverImg{
    if (!_coverImg) {
        _coverImg = [[UIImageView alloc] init];
        _coverImg.contentMode = UIViewContentModeScaleAspectFill;
        _coverImg.clipsToBounds = YES;
        _coverImg.autoresizesSubviews = YES;
    }
    return _coverImg;;
}

-(UILabel *)bookName
{
    if (!_bookName) {
        _bookName = [[UILabel alloc] init];
        _bookName.textColor = [UIColor blackColor];
        [_bookName sizeToFit];
        _bookName.font = [UIFont systemFontOfSize:16];
    }
    return _bookName;
}

-(UILabel *)authorLabel
{
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:12];
        _authorLabel.textColor = [UIColor blackColor];
       
    }
    return _authorLabel;
}

-(UILabel *)shortIntroLabel
{
    if (!_shortIntroLabel) {
        _shortIntroLabel = [[UILabel alloc] init];
        _shortIntroLabel.font = [UIFont systemFontOfSize:12];
        _shortIntroLabel.textColor = [UIColor grayColor];
        _shortIntroLabel.numberOfLines = 3;
        _shortIntroLabel.textAlignment = NSTextAlignmentLeft;
        [_shortIntroLabel sizeToFit];
    }
    return _shortIntroLabel;
}

-(UILabel *)Num
{
    if (!_Num) {
        _Num = [[UILabel alloc] init];
        _Num.font = [UIFont systemFontOfSize:16];
        _Num.textColor = [UIColor orangeColor];
        _Num.textAlignment = NSTextAlignmentRight;
    }
    return _Num;
}

-(UIView *)separate{
    if (!_separate) {
        _separate = [[UIView alloc] init];
        _separate.backgroundColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:0.99];
        
    }
    return _separate;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

-(void)configUI{
    [self.contentView addSubview:self.coverImg];
    
    [self.coverImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(self.contentView).insets(UIEdgeInsetsMake(10, 10, 10, 10));
        make.width.mas_equalTo(100);
    }];
    
    [self.contentView addSubview:self.bookName];
    [self.bookName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImg.mas_right).with.offset(10);
        make.top.equalTo(self.coverImg.mas_top);
        make.right.equalTo(self.contentView).offset(-50);
        make.height.mas_equalTo(15);
    }];
    
    [self.contentView addSubview:self.separate];
     [self.separate mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.equalTo(self.contentView);
         make.left.equalTo(self.contentView.mas_left);
         make.right.equalTo(self.contentView.mas_right);
         make.height.mas_equalTo(1);
     }];
    
    [self.contentView addSubview:self.Num];
       [self.Num mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.equalTo(self.contentView.mas_right).with.offset(-10);
           make.top.equalTo(self.bookName.mas_top);
           make.bottom.equalTo(self.bookName.mas_bottom);
           make.width.mas_equalTo(50);
       }];
    
    [self.contentView addSubview:self.shortIntroLabel];
    [self.shortIntroLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bookName.mas_left);
        make.top.equalTo(self.bookName.mas_bottom).with.offset(5);
        make.right.equalTo(self.Num.mas_left).offset(-5);
        //make.height.mas_equalTo(45);
        make.bottom.equalTo(self.coverImg.mas_bottom);
    }];
    
   
}

-(void)setModel:(JGRankModel *)model{
    _model = model;
    self.bookName.text = model.title;
    self.authorLabel.text = model.author;
    self.coverImg.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",PictureU,model.cover]]]];
    self.shortIntroLabel.text = [model.shortIntro stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.majorCate.text = model.majorCate;
    self.minorCate.text = model.minorCate;
}

@end
